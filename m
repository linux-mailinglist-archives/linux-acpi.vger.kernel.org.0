Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122162B37CF
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Nov 2020 19:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKOSeK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 15 Nov 2020 13:34:10 -0500
Received: from mail-40140.protonmail.ch ([185.70.40.140]:20609 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgKOSeK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2020 13:34:10 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Nov 2020 13:34:07 EST
Date:   Sun, 15 Nov 2020 18:33:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1605465245;
        bh=IFbVSIGItBILgBnlOZJB3FF/DMH4iODzHdw+6mnBRGI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=tVU8SpdkHQUKBG3N5vpIcsl8HaSXXh/MCuPwtBQT2McB8cSmtjXW65a9dGX1/67KW
         OUlavpARLO6WJjQeHNye92OLamKKMEupv2z4E26wpS5JVM/AusVKUFIh4bIoLRqz7G
         xiq08uJ7GFj6WwhMuNOwQu8QJQrf8NliRlxl8f9o=
To:     Mark Pearson <markpearson@lenovo.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v2 3/3] platform/x86: thinkpad_acpi: Add platform profile support
Message-ID: <bC_Z4v6vrGG27schT2V4eci6RtrHSQrt1okyeocu4rdL0tka_bmMM43h9pphEknHKMPs5dbnXG-Kzs2SwSuwTO4dOkIeIVHUgYZ5EvNrkm0=@protonmail.com>
In-Reply-To: <20201114150102.340618-3-markpearson@lenovo.com>
References: <markpearson@lenovo.com> <20201114150102.340618-1-markpearson@lenovo.com> <20201114150102.340618-3-markpearson@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


2020. november 14., szombat 16:01 keltez=C3=A9ssel, Mark Pearson <markpears=
on@lenovo.com> =C3=ADrta:

Hi


I think there are a couple places where the BIT() macro could be used.


> [...]
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/=
thinkpad_acpi.c
> index 890dda284a00..13352ccdfdaf 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -72,6 +72,7 @@
>  #include <linux/uaccess.h>
>  #include <acpi/battery.h>
>  #include <acpi/video.h>
> +#include <linux/platform_profile.h>
>
>  /* ThinkPad CMOS commands */
>  #define TP_CMOS_VOLUME_DOWN=090
> @@ -9832,10 +9833,40 @@ static struct ibm_struct lcdshadow_driver_data =
=3D {
>   * DYTC subdriver, for the Lenovo lapmode feature

This comment should be updated, no? It does more than report the "lap mode"=
 state?


>   */
>
> +#define DYTC_CMD_QUERY        0 /* To get DYTC status - enable/revision =
*/
> +#define DYTC_CMD_SET          1 /* To enable/disable IC function mode */
>  #define DYTC_CMD_GET          2 /* To get current IC function and mode *=
/
>  #define DYTC_GET_LAPMODE_BIT 17 /* Set when in lapmode */

`DYTC_GET_LAPMODE_BIT` is defined a couple lines below, I think this defini=
tion
should be removed.


> +#define DYTC_CMD_RESET    0x1ff /* To reset back to default */
> +
> +#define DYTC_QUERY_ENABLE_BIT 8  /* Bit 8 - 0 =3D disabled, 1 =3D enable=
d */
> +#define DYTC_QUERY_SUBREV_BIT 16 /* Bits 16 - 27 - sub revisision */
                                                          ^
"revision"                                                |


> +#define DYTC_QUERY_REV_BIT    28 /* Bits 28 - 31 - revision */
> +
> +#define DYTC_GET_FUNCTION_BIT 8  /* Bits 8-11 - function setting */
> +#define DYTC_GET_MODE_BIT     12 /* Bits 12-15 - mode setting */
                                              ^
The spacing is inconsistent in the comments.  |


> +#define DYTC_GET_LAPMODE_BIT  17 /* Bit 17 - lapmode. Set when on lap */
> +
> +#define DYTC_SET_FUNCTION_BIT 12 /* Bits 12-15 - funct setting */

If all letters of "function" were spelled a couple lines above, I think
it should be here as well.


> +#define DYTC_SET_MODE_BIT     16 /* Bits 16-19 - mode setting */
> +#define DYTC_SET_VALID_BIT    20 /* Bit 20 - 1 =3D on, 0 =3D off */
> +

I personally would create a DYTC_SET_COMMAND() - or similarly named - macro
along these lines:
```
#define DYTC_SET_COMMAND(function, mode, on) \
  (DYTC_CMD_SET | (function) << DYTC_SET_FUNCTION_BIT | (mode) << DYTC_SET_=
MODE_BIT | (on) << DYTC_SET_VALID_BIT)
```
and use that later on. I believe this helps readability and reduces the cha=
nces
of accindental mistakes.


> +#define DYTC_FUNCTION_STD     0  /* Function =3D 0, standard mode */
> +#define DYTC_FUNCTION_CQL     1  /* Function =3D 1, lap mode */
> +#define DYTC_FUNCTION_MMC     11 /* Function =3D 11, desk mode */

It seems strange to me that there is a leap from 1 to 11.


> +
> +#define DYTC_MODE_PERFORM     2  /* High power mode aka performance */
> +#define DYTC_MODE_QUIET       3  /* low power mode aka quiet */
> +#define DYTC_MODE_BALANCE   0xF  /* default mode aka balance */

I suggest you capitalize the last two comments to be consistent with the re=
st
of the patch.


> +
> +#define DYTC_DISABLE_CQL ((DYTC_MODE_BALANCE << DYTC_SET_MODE_BIT) | \
> +=09=09(DYTC_FUNCTION_CQL << DYTC_SET_FUNCTION_BIT) | \
> +=09=09DYTC_CMD_SET)
> +#define DYTC_ENABLE_CQL (DYTC_DISABLE_CQL | (1 << DYTC_SET_VALID_BIT))
> [...]
> +static int convert_profile_to_dytc(enum platform_profile_option profile,=
 int *perfmode)
> +{
> +=09switch (profile) {
> +=09case profile_low:
> +=09=09*perfmode =3D DYTC_MODE_QUIET;
> +=09=09break;
> +=09case profile_balance:
> +=09=09*perfmode =3D DYTC_MODE_BALANCE;
> +=09=09break;
> +=09case profile_perform:
> +=09=09*perfmode =3D DYTC_MODE_PERFORM;
> +=09=09break;
> +=09default: /* Unknown profile */
> +=09=09return -EOPNOTSUPP;

I personally think EINVAL would be better here,
just like in `convert_dytc_to_profile()`.


> +=09}
> +=09return 0;
> +}
> +
> +static int dytc_perfmode_get(int *perfmode, int *funcmode)
> +{
> +=09int output, err;
> +
> +=09if (!dytc_available)
> +=09=09return -ENODEV;
> +
> +=09err =3D dytc_command(DYTC_CMD_GET, &output);
> +=09if (err)
> +=09=09return err;
> +
> +=09*funcmode =3D (output >> DYTC_GET_FUNCTION_BIT) & 0xF;
> +=09if (*funcmode =3D=3D DYTC_FUNCTION_CQL) {
> +=09=09int dummy;
> +=09=09/*
> +=09=09 * We can't get the mode when in CQL mode - so we disable CQL
> +=09=09 * mode retrieve the mode and then enable it again.
> +=09=09 * As disabling/enabling CQL triggers an event we set a flag to
> +=09=09 * ignore these events. This will be cleared by the event handler
> +=09=09 */
> +=09=09dytc_ignore_next_event =3D true;
> +=09=09err =3D dytc_command(DYTC_DISABLE_CQL, &dummy);
> +=09=09if (err)
> +=09=09=09return err;
> +=09=09err =3D dytc_command(DYTC_CMD_GET, &output);
> +=09=09if (err)
> +=09=09=09return err;

If `DYTC_CMD_GET` fails, then CQL state is not restored. I think that may b=
e
undesired?


> +=09=09/* Again ignore this event */
> +=09=09dytc_ignore_next_event =3D true;
> +=09=09err =3D dytc_command(DYTC_ENABLE_CQL, &dummy);
> +=09=09if (err)
> +=09=09=09return err;
> +=09}
> +=09*perfmode =3D (output >> DYTC_GET_MODE_BIT) & 0xF;
> +=09return 0;
> +}
> [...]
> +/*
> + * dytc_profile_set: Function to register with platform_profile
> + * handler. Sets current platform profile.
> + */
> +int dytc_profile_set(enum platform_profile_option profile)
> +{
> +=09int cur_perfmode, cur_funcmode;
> +=09int err, dytc_set;
> +=09int output;
> +
> +=09if (!dytc_available)
> +=09=09return -ENODEV;
> +
> +=09if (profile =3D=3D profile_balance) {
> +=09=09/* To get back to balance mode we just issue a reset command */
> +=09=09err =3D dytc_command(DYTC_CMD_RESET, &output);
> +=09=09if (err)
> +=09=09=09return err;
> +=09} else {
> +=09=09int perfmode;
> +=09=09int err;
> +
> +=09=09err =3D convert_profile_to_dytc(profile, &perfmode);
> +=09=09if (err)
> +=09=09=09return err;
> +
> +=09=09/* Determine if we are in CQL mode. This alters the commands we do=
 */
> +=09=09err =3D dytc_perfmode_get(&cur_perfmode, &cur_funcmode);
> +=09=09if (err)
> +=09=09=09return err;
> +
> +=09=09if (cur_funcmode =3D=3D DYTC_FUNCTION_CQL) {
> +=09=09=09/* To set the mode we need to disable CQL first*/
> +=09=09=09dytc_ignore_next_event =3D true; /* Ignore event */
> +=09=09=09err =3D dytc_command(DYTC_DISABLE_CQL, &output);
> +=09=09=09if (err)
> +=09=09=09=09return err;
> +=09=09}
> +=09=09dytc_set =3D (1 << DYTC_SET_VALID_BIT) |
> +=09=09=09(DYTC_FUNCTION_MMC << DYTC_SET_FUNCTION_BIT) |
> +=09=09=09(perfmode << DYTC_SET_MODE_BIT) |
> +=09=09=09DYTC_CMD_SET;
> +=09=09err =3D dytc_command(dytc_set, &output);
> +=09=09if (err)
> +=09=09=09return err;

If I see it correctly, if CQL is turned off successfully, but the this comm=
and
fails, then the function returns with an error, but does not restore CQL st=
ate.
Which may or may not be desired?


> +=09=09if (cur_funcmode =3D=3D DYTC_FUNCTION_CQL) {
> +=09=09=09dytc_ignore_next_event =3D true; /* Ignore event */
> +=09=09=09err =3D dytc_command(DYTC_ENABLE_CQL, &output);
> +=09=09=09if (err)
> +=09=09=09=09return err;
> +=09=09}
> +=09}
> +=09/* Success - update current profile */
> +=09dytc_current_profile =3D profile;
> +=09return 0;
> +}
> +
> +static void dytc_profile_refresh(void)
> +{
> +=09enum platform_profile_option profile;
> +=09int perfmode, funcmode;
> +=09int err;
> +
> +=09err =3D dytc_perfmode_get(&perfmode, &funcmode);
> +=09if (err)
> +=09=09return;
> +
> +=09err =3D convert_dytc_to_profile(perfmode, &profile);

`err` is not checked.


> +=09if (profile !=3D dytc_current_profile) {
> +=09=09dytc_current_profile =3D profile;
> +=09=09platform_profile_notify();
> +=09}
> +}
> +#endif
> +
> +static int tpacpi_dytc_init(struct ibm_init_struct *iibm)
> +{
> +=09int err, output;
> +
> +=09err =3D dytc_command(DYTC_CMD_QUERY, &output);
> +=09/*
> +=09 * If support isn't available (ENODEV) then don't return an error
> +=09 * and don't create the sysfs group
>  =09 */
>  =09if (err =3D=3D -ENODEV)
>  =09=09return 0;
> @@ -9912,14 +10109,54 @@ static int tpacpi_dytc_init(struct ibm_init_stru=
ct *iibm)
>  =09if (err)
>  =09=09return err;
>
> -=09/* Platform supports this feature - create the group */
> -=09err =3D sysfs_create_group(&tpacpi_pdev->dev.kobj, &dytc_attr_group);
> -=09return err;
> +=09/* Check DYTC is enabled and supports mode setting */
> +=09dytc_available =3D false;
> +=09dytc_ignore_next_event =3D false;
> +
> +=09if (output & BIT(DYTC_QUERY_ENABLE_BIT)) {
> +=09=09/* Only DYTC v5.0 and later has this feature. */
> +=09=09int dytc_version;
> +
> +=09=09dytc_version =3D (output >> DYTC_QUERY_REV_BIT) & 0xF;
> +=09=09if (dytc_version >=3D 5) {
> +=09=09=09dbg_printk(TPACPI_DBG_INIT,
> +=09=09=09=09   "DYTC version %d: thermal mode available\n", dytc_version=
);
> +=09=09=09dytc_available =3D true;
> +#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
> +=09=09=09/* Create platform_profile structure and register */
> +=09=09=09dytc_profile.choices =3D (1 << profile_low) |
> +=09=09=09=09(1 << profile_balance) |
> +=09=09=09=09(1 << profile_perform);
> +=09=09=09dytc_profile.profile_get =3D dytc_profile_get;
> +=09=09=09dytc_profile.profile_set =3D dytc_profile_set;

By the way, wouldn't it be easier to initialize this struct when it's defin=
ed?
```
static platform_profile_handler dytc_profile =3D {
  .choices =3D ...,
  .profile_set =3D ...,
  .profile_get =3D ....,
};
```
?


> +=09=09=09err =3D platform_profile_register(&dytc_profile);
> +=09=09=09/*
> +=09=09=09 * If for some reason platform_profiles aren't enabled
> +=09=09=09 * don't quit terminally.
> +=09=09=09 */
> +=09=09=09if (err)
> +=09=09=09=09return 0;

If I see it correctly, if `platform_profile_register()` fails for some reas=
on,
then the dytc_lapmode attribute won't be created, is that the expected beha=
viour?


> +#endif
> +=09=09=09/*
> +=09=09=09 * Note - this has been deprecated by the input sensor implemen=
tation,
> +=09=09=09 * but can't be removed until we confirm user space is no longe=
r using
> +=09=09=09 */
> +=09=09=09dytc_lapmode_get(&dytc_lapmode);
> +=09=09=09return device_create_file(&tpacpi_pdev->dev, &dev_attr_dytc_lap=
mode);

Previously, the DYTC version (and the "enable bit") wasn't checked, the lap=
 mode
attribute was always created if DYTC was available. This patch changes that=
,
why?


> +=09=09}
> +=09}
> +=09return 0;
>  }
>
>  static void dytc_exit(void)
>  {
> -=09sysfs_remove_group(&tpacpi_pdev->dev.kobj, &dytc_attr_group);
> +=09if (dytc_available) {
> +=09=09device_remove_file(&tpacpi_pdev->dev, &dev_attr_dytc_lapmode);
> +#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
> +=09=09platform_profile_unregister();

`platform_profile_unregister()` is called even if `platform_profile_registe=
r()`
failed.


> +#endif
> +=09=09dytc_available =3D false;
> +=09}
>  }
>
>  static struct ibm_struct dytc_driver_data =3D {
> @@ -10103,8 +10340,15 @@ static void tpacpi_driver_event(const unsigned i=
nt hkey_event)
>  =09}
>
>  =09if (hkey_event =3D=3D TP_HKEY_EV_THM_CSM_COMPLETED) {
> -=09=09dytc_lapmode_refresh();
> -=09=09lapsensor_refresh();
> +=09=09if (dytc_ignore_next_event)
> +=09=09=09dytc_ignore_next_event =3D false; /*clear setting*/

Either none or all of the blocks should be surrounded with {} [1].


> +=09=09else {
> +=09=09=09dytc_lapmode_refresh();
> +#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
> +=09=09=09dytc_profile_refresh();
> +#endif
> +=09=09=09lapsensor_refresh();
> +=09=09}
>  =09}
>
>  }
> --
> 2.25.1


[1]: https://www.kernel.org/doc/html/latest/process/coding-style.html#placi=
ng-braces-and-spaces


Regards,
Barnab=C3=A1s P=C5=91cze
