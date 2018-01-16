<div class="field-group radio-group color-group">
    <div class="field-title">
        <?= $field['title'] ?>
    </div>

    <input type="hidden" name="<?= $field['name'] ?>" value="<?= $value ?>">

    <?php foreach ($field['values'] as $key => $title): ?>
        <label>
            <input type="radio" name="<?= $field['name'] ?>" value="<?= $key ?>"<?= $key == $value ? ' checked' : '' ?>>
            <span><?= $title ?></span>
        </label>
    <?php endforeach; ?>

    <div class="color-selector"></div>
</div>