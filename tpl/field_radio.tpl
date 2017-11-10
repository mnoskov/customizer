<div class="field-group radio-group">
    <div class="field-title">
        <?= $field['title'] ?>
    </div>

    <?php foreach ($field['values'] as $key => $title): ?>
        <label>
            <input type="radio" name="<?= $field['name'] ?>" value="<?= $key ?>"<?= $key == $value ? ' checked' : '' ?>>
            <span><?= $title ?></span>
        </label>
    <?php endforeach; ?>
</div>