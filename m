Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5776664DD
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jan 2023 21:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjAKUb0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Jan 2023 15:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjAKUbQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jan 2023 15:31:16 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158FA15F1F
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2023 12:31:07 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id cf18so33452266ejb.5
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2023 12:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bl/JsC7wnt2ld4qlgPWYMbtWRmZ3orZvYqEpF3vayx4=;
        b=L+GzlK1l5bG+SGr5xL9dfyNlebaddzvEE7Fy8aput71z9YroFvKqtLN8RZ2b7iYMJP
         Am9XyhxNQMpZYNb+BkOWZ95hB+U0wCW3a3lhUeva0YI+/fxIGJzj7DJg9LzXn0E/YxlT
         SvynR7Wug8QkWx+Dg/U9gp6w7e2566JcrNnSRl0gGY551mEwpZyZFj7OA5WHwguNu0iF
         QxXSt6Q3PiTRoVPiOVr+VBhXFG/GKEc4IGrjni3qp/pq9WujjzrARLzTwURpH+XOTrt8
         SOhiVAwna+c0AVM59v0dL+RpfxE1dprw7oNQBc+jAAJoWDyobTMzBNBYZ7DP1Sb3TDCx
         0m/Q==
X-Gm-Message-State: AFqh2kpGaCsOfx77nU1M8bB7gYD+NegUvGFkzn+Y5N/QuUHXIaLc5ASF
        ZBHfXWK8JHPf3v6Fmgqactnwc9YGLdDJNHR9VGE=
X-Google-Smtp-Source: AMrXdXvFGvlS5gRQ/vKRN+Yc7hPmipntQ68Ys4jOGh5Ypm4T4Dh7R9rRZf7ooUzLbDkWKKccfQwpaSkKdmR/eY84aIk=
X-Received: by 2002:a17:906:9484:b0:84d:3c6a:4c55 with SMTP id
 t4-20020a170906948400b0084d3c6a4c55mr2041611ejx.509.1673469065648; Wed, 11
 Jan 2023 12:31:05 -0800 (PST)
MIME-Version: 1.0
References: <20230110153028.183294-1-hdegoede@redhat.com> <CAJZ5v0gVJtvuO-G1DiO3WffWTMJMjt-N_W4XKNgTTw0R5F1iOQ@mail.gmail.com>
 <ea35e7a1-276e-2997-a3a8-e55ae7855fa6@redhat.com>
In-Reply-To: <ea35e7a1-276e-2997-a3a8-e55ae7855fa6@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Jan 2023 21:30:53 +0100
Message-ID: <CAJZ5v0g4LHRfz3YtobbR+5m-uJm2TSHrZU3PKJ5Psuk6RXzp5g@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Fix selecting the wrong ACPI fwnode for the iGPU
 on some Dell laptops
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 11, 2023 at 9:23 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/11/23 21:16, Rafael J. Wysocki wrote:
> > On Tue, Jan 10, 2023 at 4:30 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> The Dell Latitude E6430 both with and without the optional NVidia dGPU
> >> has a bug in its ACPI tables which is causing Linux to assign the wrong
> >> ACPI fwnode / companion to the pci_device for the i915 iGPU.
> >>
> >> Specifically under the PCI root bridge there are these 2 ACPI Device()s :
> >>
> >>  Scope (_SB.PCI0)
> >>  {
> >>      Device (GFX0)
> >>      {
> >>          Name (_ADR, 0x00020000)  // _ADR: Address
> >>      }
> >>
> >>      ...
> >>
> >>      Device (VID)
> >>      {
> >>          Name (_ADR, 0x00020000)  // _ADR: Address
> >>          ...
> >>
> >>          Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
> >>          {
> >>              VDP8 = Arg0
> >>              VDP1 (One, VDP8)
> >>          }
> >>
> >>          Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
> >>          {
> >>              ...
> >>          }
> >>          ...
> >>      }
> >>  }
> >>
> >> The non-functional GFX0 ACPI device is a problem, because this gets
> >> returned as ACPI companion-device by acpi_find_child_device() for the iGPU.
> >>
> >> This is a long standing problem and the i915 driver does use the ACPI
> >> companion for some things, but works fine without it.
> >>
> >> However since commit 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()")
> >> acpi_get_pci_dev() relies on the physical-node pointer in the acpi_device
> >> and that is set on the wrong acpi_device because of the wrong
> >> acpi_find_child_device() return. This breaks the ACPI video code,
> >> leading to non working backlight control in some cases.
> >>
> >> Add a type.backlight flag, mark ACPI video bus devices with this and make
> >> find_child_checks() return a higher score for children with this flag set,
> >> so that it picks the right companion-device.
> >>
> >> Co-developed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >> Changes in v2:
> >> - Switch to Rafael's suggested implementation using a type.backlight flag
> >>   and only make find_child_checks() return a higher score when this is set
> >> ---
> >>  drivers/acpi/glue.c     | 14 ++++++++++++--
> >>  drivers/acpi/scan.c     |  7 +++++--
> >>  include/acpi/acpi_bus.h |  3 ++-
> >>  3 files changed, 19 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> >> index 204fe94c7e45..a194f30876c5 100644
> >> --- a/drivers/acpi/glue.c
> >> +++ b/drivers/acpi/glue.c
> >> @@ -75,7 +75,8 @@ static struct acpi_bus_type *acpi_get_bus_type(struct device *dev)
> >>  }
> >>
> >>  #define FIND_CHILD_MIN_SCORE   1
> >> -#define FIND_CHILD_MAX_SCORE   2
> >> +#define FIND_CHILD_MID_SCORE   2
> >> +#define FIND_CHILD_MAX_SCORE   3
> >>
> >>  static int match_any(struct acpi_device *adev, void *not_used)
> >>  {
> >> @@ -96,8 +97,17 @@ static int find_child_checks(struct acpi_device *adev, bool check_children)
> >>                 return -ENODEV;
> >>
> >>         status = acpi_evaluate_integer(adev->handle, "_STA", NULL, &sta);
> >> -       if (status == AE_NOT_FOUND)
> >> +       if (status == AE_NOT_FOUND) {
> >> +               /*
> >> +                * Special case: backlight device objects without _STA are
> >> +                * preferred to other objects with the same _ADR value, because
> >> +                * it is more likely that they are actually useful.
> >> +                */
> >> +               if (adev->pnp.type.backlight)
> >> +                       return FIND_CHILD_MID_SCORE;
> >> +
> >>                 return FIND_CHILD_MIN_SCORE;
> >> +       }
> >>
> >>         if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_ENABLED))
> >>                 return -ENODEV;
> >> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> >> index 274344434282..0c6f06abe3f4 100644
> >> --- a/drivers/acpi/scan.c
> >> +++ b/drivers/acpi/scan.c
> >> @@ -1370,9 +1370,12 @@ static void acpi_set_pnp_ids(acpi_handle handle, struct acpi_device_pnp *pnp,
> >>                  * Some devices don't reliably have _HIDs & _CIDs, so add
> >>                  * synthetic HIDs to make sure drivers can find them.
> >>                  */
> >> -               if (acpi_is_video_device(handle))
> >> +               if (acpi_is_video_device(handle)) {
> >>                         acpi_add_id(pnp, ACPI_VIDEO_HID);
> >> -               else if (acpi_bay_match(handle))
> >> +                       pnp->type.backlight = 1;
> >> +                       break;
> >> +               }
> >> +               if (acpi_bay_match(handle))
> >>                         acpi_add_id(pnp, ACPI_BAY_HID);
> >>                 else if (acpi_dock_match(handle))
> >>                         acpi_add_id(pnp, ACPI_DOCK_HID);
> >> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> >> index cd3b75e08ec3..e44be31115a6 100644
> >> --- a/include/acpi/acpi_bus.h
> >> +++ b/include/acpi/acpi_bus.h
> >> @@ -230,7 +230,8 @@ struct acpi_pnp_type {
> >>         u32 hardware_id:1;
> >>         u32 bus_address:1;
> >>         u32 platform_id:1;
> >> -       u32 reserved:29;
> >> +       u32 backlight:1;
> >> +       u32 reserved:28;
> >>  };
> >>
> >>  struct acpi_device_pnp {
> >> --
> >
> > Applied as 6.2-rc material, thanks!
>
> Thanks.
>
> I just realized this probably needs a:
>
> Fixes: 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()")
>
> tag, so that it gets picked up for 6.1.y

I've added that tag to it, thanks!
