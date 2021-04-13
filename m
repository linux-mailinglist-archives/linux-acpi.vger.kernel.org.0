Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFCD35E273
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Apr 2021 17:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhDMPQA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Apr 2021 11:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhDMPQA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Apr 2021 11:16:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAA2C061574;
        Tue, 13 Apr 2021 08:15:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso9152851pjb.3;
        Tue, 13 Apr 2021 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h8boox+bZPa3iJwz4p9B118690quv4s9PGlIg8eOoQc=;
        b=c+UHUxMljZyUWkJQd7XCuX3HJ+bBq8PQEJ1ZoDwQPRbkcU8LFADydu4kIhCG8vKmf5
         5B1YanHhRs4VHmqbTRqQq4w2Rw9zOqbDEoUtnMjdjFcSDEg0ORd1HqAf4Byvu60jUDxa
         IUlv2CG75eWq5gk70jO8Mxmyo1ael00lcZ5Q/8PNyl7GfmKIriOOUw/hKZ1e09wxXQXp
         jdrdX3vG4ex6MGbxH8TJCpUJmN9UVyhuZa9p149oKMYQceZ+Sb1BQxqNJZtUFPQ2C9bA
         3/3YB2AnAH9UkDszCQnIGgpU6znim1bH6ZxbUtoCVAcv88RrhiXd4KlbsC3KYdD5WrQs
         p2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h8boox+bZPa3iJwz4p9B118690quv4s9PGlIg8eOoQc=;
        b=mCB9NEsQj0kjP/yaCrgOPFcXOTyrRhQquqKrj0NUEPn6DT9YhOEloGfXlr4vGFxcQ+
         0x8kl9On3PIqF0vgGZAHpnwVeBdWiwo4jEZ+5r2ODsv0XxCCMzoE/gQKankOjsgoqODu
         fXUmpi7Gpif1t251ilvgwRiEjnyz69vKKH+cYRaXpOf2LJC9FM6L7mB3gK9W4PrjOdRq
         E475pvDnQcnU05Zh58ftoP6den98E3lwjayv5aMyvH8PCtd1ZILPeK/XhDNGw5NUNBDa
         bqOGxGASOplfAztJnufGGHxeC93D6mOA61VKh4yBkeeB7XykanyXf3aAEu/s0c7l5S7E
         0EyQ==
X-Gm-Message-State: AOAM531JSt14NcY9ylIQaRNEN1M5ojEXDM6/buJLAOD4eJBfnLesWHQX
        Wbgx7Bhjw772yC/qORimTJ8XPeDilZ2Hylbce/IUWajNGi+NX/Gf
X-Google-Smtp-Source: ABdhPJwTqc8GtqCuGhDPrez1P1RZSHLbj+/YwlxGpDVUTXd0HtKfufaTO/bOfd0lFdlIczZudoflOyNMOywd6USFmbQ=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr32050277plq.17.1618326940217; Tue, 13
 Apr 2021 08:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <2090a4ab-bb07-140a-f794-764f18969854@fabwu.ch> <20210413063435.18111-1-me@fabwu.ch>
In-Reply-To: <20210413063435.18111-1-me@fabwu.ch>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 13 Apr 2021 18:15:23 +0300
Message-ID: <CAHp75VfkWAZ0rZQw_UGKdzdEZ9era-rizRJXfn+ZfQPkTDZRmQ@mail.gmail.com>
Subject: Re: [PATCH v2] ipu3-cio2: Parse sensor orientation and rotation
To:     =?UTF-8?Q?Fabian_W=C3=BCthrich?= <me@fabwu.ch>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Dan Scally <djrscally@gmail.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 13, 2021 at 12:02 PM Fabian W=C3=BCthrich <me@fabwu.ch> wrote:
>
> The sensor orientation is read from the _PLC ACPI buffer and converted
> to a v4l2 format.
>
> See https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.p=
df
> page 351 for a definition of the Panel property.

Better to refer to the version, chapter number and title, like]

  ACPI specification v6.3 defines that in the chapter 6.1.8 "_PLD
(Physical Location of Device)"

> The sensor rotation is read from the SSDB ACPI buffer and converted into
> degrees.

After splitting to two patches, take my
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Fabian W=C3=BCthrich <me@fabwu.ch>
> Reviewed-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v2:
>   - Move ACPI PLD constants to ACPI headers
>   - Fix dev_properties size
>
>  drivers/media/pci/intel/ipu3/cio2-bridge.c | 60 ++++++++++++++++++++--
>  drivers/media/pci/intel/ipu3/cio2-bridge.h |  9 +++-
>  include/acpi/acbuffer.h                    |  9 ++++
>  3 files changed, 73 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/p=
ci/intel/ipu3/cio2-bridge.c
> index c2199042d3db..926141e9a516 100644
> --- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
> +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
> @@ -29,6 +29,7 @@ static const struct cio2_sensor_config cio2_supported_s=
ensors[] =3D {
>  static const struct cio2_property_names prop_names =3D {
>         .clock_frequency =3D "clock-frequency",
>         .rotation =3D "rotation",
> +       .orientation =3D "orientation",
>         .bus_type =3D "bus-type",
>         .data_lanes =3D "data-lanes",
>         .remote_endpoint =3D "remote-endpoint",
> @@ -72,11 +73,51 @@ static int cio2_bridge_read_acpi_buffer(struct acpi_d=
evice *adev, char *id,
>         return ret;
>  }
>
> +static u32 cio2_bridge_parse_rotation(struct cio2_sensor *sensor)
> +{
> +       switch (sensor->ssdb.degree) {
> +       case CIO2_SENSOR_ROTATION_NORMAL:
> +               return 0;
> +       case CIO2_SENSOR_ROTATION_INVERTED:
> +               return 180;
> +       default:
> +               dev_warn(&sensor->adev->dev,
> +                        "Unknown rotation %d. Assume 0 degree rotation\n=
",
> +                        sensor->ssdb.degree);
> +               return 0;
> +       }
> +}
> +
> +static enum v4l2_fwnode_orientation cio2_bridge_parse_orientation(struct=
 cio2_sensor *sensor)
> +{
> +       switch (sensor->pld->panel) {
> +       case ACPI_PLD_PANEL_FRONT:
> +               return V4L2_FWNODE_ORIENTATION_FRONT;
> +       case ACPI_PLD_PANEL_BACK:
> +               return V4L2_FWNODE_ORIENTATION_BACK;
> +       case ACPI_PLD_PANEL_TOP:
> +       case ACPI_PLD_PANEL_LEFT:
> +       case ACPI_PLD_PANEL_RIGHT:
> +       case ACPI_PLD_PANEL_UNKNOWN:
> +               return V4L2_FWNODE_ORIENTATION_EXTERNAL;
> +       default:
> +               dev_warn(&sensor->adev->dev, "Unknown _PLD panel value %d=
\n",
> +                        sensor->pld->panel);
> +               return V4L2_FWNODE_ORIENTATION_EXTERNAL;
> +       }
> +}
> +
>  static void cio2_bridge_create_fwnode_properties(
>         struct cio2_sensor *sensor,
>         struct cio2_bridge *bridge,
>         const struct cio2_sensor_config *cfg)
>  {
> +       u32 rotation;
> +       enum v4l2_fwnode_orientation orientation;
> +
> +       rotation =3D cio2_bridge_parse_rotation(sensor);
> +       orientation =3D cio2_bridge_parse_orientation(sensor);
> +
>         sensor->prop_names =3D prop_names;
>
>         sensor->local_ref[0].node =3D &sensor->swnodes[SWNODE_CIO2_ENDPOI=
NT];
> @@ -85,9 +126,12 @@ static void cio2_bridge_create_fwnode_properties(
>         sensor->dev_properties[0] =3D PROPERTY_ENTRY_U32(
>                                         sensor->prop_names.clock_frequenc=
y,
>                                         sensor->ssdb.mclkspeed);
> -       sensor->dev_properties[1] =3D PROPERTY_ENTRY_U8(
> +       sensor->dev_properties[1] =3D PROPERTY_ENTRY_U32(
>                                         sensor->prop_names.rotation,
> -                                       sensor->ssdb.degree);
> +                                       rotation);
> +       sensor->dev_properties[2] =3D PROPERTY_ENTRY_U32(
> +                                       sensor->prop_names.orientation,
> +                                       orientation);
>
>         sensor->ep_properties[0] =3D PROPERTY_ENTRY_U32(
>                                         sensor->prop_names.bus_type,
> @@ -159,6 +203,7 @@ static void cio2_bridge_unregister_sensors(struct cio=
2_bridge *bridge)
>         for (i =3D 0; i < bridge->n_sensors; i++) {
>                 sensor =3D &bridge->sensors[i];
>                 software_node_unregister_nodes(sensor->swnodes);
> +               ACPI_FREE(sensor->pld);
>                 acpi_dev_put(sensor->adev);
>         }
>  }
> @@ -170,6 +215,7 @@ static int cio2_bridge_connect_sensor(const struct ci=
o2_sensor_config *cfg,
>         struct fwnode_handle *fwnode;
>         struct cio2_sensor *sensor;
>         struct acpi_device *adev;
> +       acpi_status status;
>         int ret;
>
>         for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
> @@ -193,11 +239,15 @@ static int cio2_bridge_connect_sensor(const struct =
cio2_sensor_config *cfg,
>                 if (ret)
>                         goto err_put_adev;
>
> +               status =3D acpi_get_physical_device_location(adev->handle=
, &sensor->pld);
> +               if (ACPI_FAILURE(status))
> +                       goto err_put_adev;
> +
>                 if (sensor->ssdb.lanes > CIO2_MAX_LANES) {
>                         dev_err(&adev->dev,
>                                 "Number of lanes in SSDB is invalid\n");
>                         ret =3D -EINVAL;
> -                       goto err_put_adev;
> +                       goto err_free_pld;
>                 }
>
>                 cio2_bridge_create_fwnode_properties(sensor, bridge, cfg)=
;
> @@ -205,7 +255,7 @@ static int cio2_bridge_connect_sensor(const struct ci=
o2_sensor_config *cfg,
>
>                 ret =3D software_node_register_nodes(sensor->swnodes);
>                 if (ret)
> -                       goto err_put_adev;
> +                       goto err_free_pld;
>
>                 fwnode =3D software_node_fwnode(&sensor->swnodes[
>                                                       SWNODE_SENSOR_HID])=
;
> @@ -226,6 +276,8 @@ static int cio2_bridge_connect_sensor(const struct ci=
o2_sensor_config *cfg,
>
>  err_free_swnodes:
>         software_node_unregister_nodes(sensor->swnodes);
> +err_free_pld:
> +       ACPI_FREE(sensor->pld);
>  err_put_adev:
>         acpi_dev_put(sensor->adev);
>  err_out:
> diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.h b/drivers/media/p=
ci/intel/ipu3/cio2-bridge.h
> index dd0ffcafa489..202c7d494f7a 100644
> --- a/drivers/media/pci/intel/ipu3/cio2-bridge.h
> +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.h
> @@ -12,6 +12,10 @@
>  #define CIO2_MAX_LANES                         4
>  #define MAX_NUM_LINK_FREQS                     3
>
> +/* Values are educated guesses as we don't have a spec */
> +#define CIO2_SENSOR_ROTATION_NORMAL            0
> +#define CIO2_SENSOR_ROTATION_INVERTED          1
> +
>  #define CIO2_SENSOR_CONFIG(_HID, _NR, ...)     \
>         (const struct cio2_sensor_config) {     \
>                 .hid =3D _HID,                    \
> @@ -80,6 +84,7 @@ struct cio2_sensor_ssdb {
>  struct cio2_property_names {
>         char clock_frequency[16];
>         char rotation[9];
> +       char orientation[12];
>         char bus_type[9];
>         char data_lanes[11];
>         char remote_endpoint[16];
> @@ -106,9 +111,11 @@ struct cio2_sensor {
>         struct cio2_node_names node_names;
>
>         struct cio2_sensor_ssdb ssdb;
> +       struct acpi_pld_info *pld;
> +
>         struct cio2_property_names prop_names;
>         struct property_entry ep_properties[5];
> -       struct property_entry dev_properties[3];
> +       struct property_entry dev_properties[4];
>         struct property_entry cio2_properties[3];
>         struct software_node_ref_args local_ref[1];
>         struct software_node_ref_args remote_ref[1];

...

> --- a/include/acpi/acbuffer.h
> +++ b/include/acpi/acbuffer.h
> @@ -207,4 +207,13 @@ struct acpi_pld_info {
>  #define ACPI_PLD_GET_HORIZ_OFFSET(dword)        ACPI_GET_BITS (dword, 16=
, ACPI_16BIT_MASK)
>  #define ACPI_PLD_SET_HORIZ_OFFSET(dword,value)  ACPI_SET_BITS (dword, 16=
, ACPI_16BIT_MASK, value)      /* Offset 128+16=3D144, Len 16 */
>
> +/* Panel position defined in _PLD section of ACPI Specification 6.3 */
> +#define ACPI_PLD_PANEL_TOP                     0
> +#define ACPI_PLD_PANEL_BOTTOM                  1
> +#define ACPI_PLD_PANEL_LEFT                    2
> +#define ACPI_PLD_PANEL_RIGHT                   3
> +#define ACPI_PLD_PANEL_FRONT                   4
> +#define ACPI_PLD_PANEL_BACK                    5
> +#define ACPI_PLD_PANEL_UNKNOWN                 6
> +
>  #endif                         /* ACBUFFER_H */

I assume this is a separate patch against ACPICA.

--=20
With Best Regards,
Andy Shevchenko
