# Обновления OdinOS через GitHub

Для обновлений нужен GitHub-репозиторий, например `vines-updates`. Новые версии публикуются через раздел **Releases**.

## 1. Создать репозиторий

На GitHub выбери **New repository** и создай:

```text
vines-updates
```

Репозиторий можно сделать публичным. Не загружай в него приватный Minisign-ключ.

## 2. Создать новую версию

Для версии `0.2.0` подготовь три файла:

```text
odinos-system-0.2.0.pkg.tar.zst
odinos-system-0.2.0.pkg.tar.zst.minisig
manifest.json
```

Пример `manifest.json`:

```json
{
  "version": "0.2.0",
  "package_url": "https://github.com/xxxonilmini-ops/vines-updates/releases/download/v0.2.0/odinos-system-0.2.0.pkg.tar.zst",
  "sha256": "SHA256_ХЭШ_ПАКЕТА",
  "signature_url": "https://github.com/xxxonilmini-ops/vines-updates/releases/download/v0.2.0/odinos-system-0.2.0.pkg.tar.zst.minisig"
}
```

## 3. Опубликовать Release

В репозитории открой **Releases** -> **Draft a new release**.

- Tag: `v0.2.0`
- Title: `OdinOS 0.2.0`
- Добавь три файла в раздел Assets
- Нажми **Publish release**

## 4. Подключить OdinOS

В файле `profile/airootfs/etc/vines/vines-updater.conf` замени `YOUR_ACCOUNT` на имя GitHub-пользователя и укажи настоящий публичный Minisign-ключ.

```ini
VINES_MANIFEST_URL="https://github.com/USERNAME/vines-updates/releases/latest/download/manifest.json"
VINES_PUBLIC_KEY="ТВОЙ_ПУБЛИЧНЫЙ_MINISIGN_КЛЮЧ"
VINES_PACKAGE_NAME="odinos-system"
```

## Автоматическая публикация

Файл `.github/workflows/publish-vines-update.yml` собирает пакет и публикует Release через GitHub Actions. Его нужно добавить в репозиторий `vines-updates` вместе с папкой `release/vines-system`.

Создай ключи на своем компьютере:

```bash
minisign -G -W -p vines.pub -s vines.key
```

Содержимое `vines.key` добавь в репозитории `vines-updates` в **Settings -> Secrets and variables -> Actions** с именем `MINISIGN_SECRET_KEY`. Содержимое `vines.pub` укажи в `vines-updater.conf` как `VINES_PUBLIC_KEY`.

Приватный файл `vines.key` нельзя загружать в GitHub или добавлять в проект.

## Важно

Приватный ключ подписи хранится только у разработчика. В GitHub загружается только публичный ключ и файл `.minisig`.
