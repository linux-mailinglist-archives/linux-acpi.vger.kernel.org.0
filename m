Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C95D4A9ECC
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Feb 2022 19:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377467AbiBDSQx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Feb 2022 13:16:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:24419 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243150AbiBDSQw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Feb 2022 13:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643998612; x=1675534612;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7yDeSA5FxKlyjf7WVjbYp5uk7enNQr9sv4NwryTzZnI=;
  b=d/TQm7EJquxXj4GFSL5/LkSGkcsUfCC/mMu89jIwaSatc0bGDHd3lJAx
   pKQ4++36EJNpfv6N84FLMIGsmhVNqbvTcYNOBc+K2N36qwo1/F8JSwqKJ
   7bUSGsj6clCkHu8hCRIcSGQh8yOD5s36cDRlGE14lnmeVi0LCsJSS7L1+
   4GiMdKv5LpeNqOIzxNhQhF0TH6cCWOOrAor5e9v/7G3HwMe932A1yZl4R
   L+cX7rRcDfyGQf/VhJtUnVGkaSowrK7DpQzGIUFS1fMMAvqzS3LnH1KXd
   yXfryWMdvFlTHyRvm8GzeZ7k1BUniI58bMzSHMdTqllqcM2OWbYSPcBeA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="247248591"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="247248591"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 10:16:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="566813557"
Received: from ahofrock-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.64.72])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 10:16:52 -0800
Message-ID: <1eac284d60ba4050740f2692eadf49d03ea1cf37.camel@linux.intel.com>
Subject: Re: [PATCH v3] ACPI / fan: Properly handle fine grain control
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Date:   Fri, 04 Feb 2022 10:16:51 -0800
In-Reply-To: <dae13602d4b4178ae86a749a9b6473fb64b82679.camel@linux.intel.com>
References: <20220128235118.1693865-1-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0iJph04mtGabTXLY_7FqaA9tCnFwz=-+DR=n3G3GC6Szg@mail.gmail.com>
         <dae13602d4b4178ae86a749a9b6473fb64b82679.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2022-02-03 at 13:54 -0800, srinivas pandruvada wrote:
> On Thu, 2022-02-03 at 21:13 +0100, Rafael J. Wysocki wrote:
> > On Sat, Jan 29, 2022 at 12:51 AM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > > 
> > > 
> 
> [...]
> 
> > > To support fine grain control (when supported) via thermal sysfs:
> > > - cooling device max state is not _FPS state count but it will be
> > > 100 / _FIF.step_size
> > > - cooling device current state is 100 / _FIF.step_size
> > 
> > I don't quite understand this.
> > 
> > The max state and the current state should not always be the same,
> > should they?
> 
> This sentence needs correction.
> The  current_state is _FST.control/_FIF.step_size.
> 
> > 
> > > - cooling device set state will set the control value
> > > 
> 
> [...]
> 
> > > -       else
> > > +       if (fan->acpi4) {
> > > +               if (fan->fif.fine_grain_ctrl)
> > > +                       *state = 100 / (int)fan->fif.step_size;
> > 
> > Is it really necessary to explicitly cast fif.step_size to int?
> This was reported by LKP as fan->fif.step_size is 64 bit. This driver
> doesn't restrict to 64 bit.
> 
> "undefined reference to `__udivdi3" for i386-defconfig.
> > 
> > > +               else
> > > +                       *state = fan->fps_count - 1;
> > > 
> 
> [...]
> 
> > > -static int fan_get_state_acpi4(struct acpi_device *device,
> > > unsigned long *state)
> > > +static int fan_get_fps(struct acpi_device *device, struct
> > > acpi_fan_fst *fst)
> > 
> > Why is this called fan_get_fps()?  I'd rather call it
> > acpi_fan_get_fst().
> I can change that.
> 
> > 
> > >  {
> > >         struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL
> > > };
> > > -       struct acpi_fan *fan = acpi_driver_data(device);
> > >         union acpi_object *obj;
> > >         acpi_status status;
> > > -       int control, i;
> > > 
> > >         status = acpi_evaluate_object(device->handle, "_FST",
> > > NULL,
> > > &buffer);
> > >         if (ACPI_FAILURE(status)) {
> > > @@ -119,31 +130,51 @@ static int fan_get_state_acpi4(struct
> > > acpi_device *device, unsigned long *state)
> > >                 goto err;
> > >         }
> > > 
> > > -       control = obj->package.elements[1].integer.value;
> > > +       fst->revision = obj->package.elements[0].integer.value;
> > > +       fst->control = obj->package.elements[1].integer.value;
> > > +       fst->speed = obj->package.elements[2].integer.value;
> > > +
> > > +       status = 0;
> > > +err:
> > > +       kfree(obj);
> > > +       return status;
> > 
> > There is some confusion regarding the error return values in this
> > function, would be good to fix it while doing this.
> > 
> Let me check that.
> 
> > > +}
> > > +
> > > +static int fan_get_state_acpi4(struct acpi_device *device,
> > > unsigned long *state)
> > > +{
> > > +       struct acpi_fan *fan = acpi_driver_data(device);
> > > +       struct acpi_fan_fst fst;
> > > +       int status;
> > > +       int control, i;
> > > +
> > > +       status = fan_get_fps(device, &fst);
> > > +       if (status)
> > > +               return status;
> > > +
> > > +       control = fst.control;
> > > +
> > > +       if (fan->fif.fine_grain_ctrl) {
> > > +               /* This control should be same what we set using
> > > _FSL by spec */
> > > +               if (control > 100) {
> > > +                       dev_dbg(&device->dev, "Invalid control
> > > value returned\n");
> > > +                       return -EINVAL;
> > 
> > Why don't we fall back to the other method in this case?
> We can.
> 
> > 
> > > +               }
> > > +
> > > +               *state = control / (int)fan->fif.step_size;
> > 
> > Do we care about rounding errors?
> > 
> > Say control is 8 and step_size is 9.  Should this count as 0 or as
> > 1?
> > 
> We will not set control value to 8 in this case, so we shouldn't read
> 8. But if firmware setup at boot then it will be 0. The compensation
> to
> reach 100 is at last step which is allowed.
> 
> If step size is 9
> 
> thermal sysfs will display
>         max_state = 100/9 = 11
> 
> control         thermal sysfs cur_state
> 0-8             0
> 9-17            1
> 18-26           2
> 27-35           3
> 36-44           4
> 45-53           5
> 54-62           6
> 63-71           7
> 72-80           8
> 81-89           9
> 90-98           10
> 99-100          11
> 
> If step size is 10
> thermal sysfs
>         max_state = 100/10 = 10
> control         thermal sysfs cur_state
> 0-9             0
> 10-19           1
> 20-29           2
> 30-39           3
> 40-49           4
> 50-59           5
> 60-69           6
> 70-79           7
> 80-89           8
> 90-99           9
> 100             10
> 
> 
> 
> > > +               return 0;
> > > +       }
> 
> [...]
> 
> > > -       if (state >= fan->fps_count)
> > > +       if (state > max_state)
> > 
> > Say step_size is 9, so max_state is 11.  state == 12 would still be
> > valid, no?
> We are presenting thermal sysfs max_state as 11 in this case, so
> state 0-11 are valid. To reach 100, the spec allows to compensate the
> last step to reach 100%. So state 11 is 100% not 99% as in the above
> table.
> 
> If we present max_state as 12 then also user space can't choose max
> than 12, so (state > max_state) will be still an error.
> 
> If we present max state as 12 then in the above table:
> control         state
> ----------------------
> 90              10
> 99              11
> 100             12
> 
> Then last state will increase control value by 1.
> 
> 
> > 
> > >                 return -EINVAL;
> > > 
> > > -       status = acpi_execute_simple_method(device->handle,
> > > "_FSL",
> > > -                                           fan-
> > > > fps[state].control);
> > > +       if (fan->fif.fine_grain_ctrl) {
> > > +               int rem;
> > > +
> > > +               value *= fan->fif.step_size;
> > 
> > And you don't need the max_state computation for this, it's only
> > necessary to cap value at 100.  In which case you also wouldn't
> > need
> > rem etc.
Correct.
We don't need calculation. When the value == max_step, the control
value will be 100.


> For above example to set the state 11 for 100 for step size 9. If
> max_state is chosen as 12 then we can just cap.
> 
> > 
> > > +
> > > +               /*
> > > +                * In the event OSPM’s incremental selections of
> > > Level
> > > +                * using the StepSize field value do not sum to
> > > 100%,
> > > +                * OSPM may select an appropriate ending Level
> > > +                * increment to reach 100%.
> > > +                */
> > > +               rem = 100 - value;
> > > +               if (rem && rem < fan->fif.step_size)
> > > +                       value = 100;
> > > +       } else {
> > > +               value = fan->fps[state].control;
> > > 
> 
> [...]
> 
> > > +       if (!fan->fif.step_size)
> > > +               fan->fif.step_size = 1;
> > > +       /* If step size > 9, change to 9 (by spec valid values 1-
> > > 9)
> > > */
> > > +       if (fan->fif.step_size > 9)
> > 
> > I would do "else if" here, because both the above conditions cannot
> > hold at the same time.
> OK
> 
> > 
> > > +               fan->fif.step_size = 9;
> > >  err:
> > > 
> 
> [...]
> 
> > > +       sysfs_attr_init(&fan->fine_grain_control.attr);
> > > +       fan->fine_grain_control.show = show_fine_grain_control;
> > > +       fan->fine_grain_control.store = NULL;
> > > +       fan->fine_grain_control.attr.name = "fine_grain_control";
> > > +       fan->fine_grain_control.attr.mode = 0444;
> > > +       status = sysfs_create_file(&device->dev.kobj, &fan-
> > > > fine_grain_control.attr);
> > 
> > I would split the creation of the new attributes into a separate
> > file,
> > for clarity (and to help the review somewhat).
> > 
> We can move all the attributes including the current one to a new
> file.
> 
> Thanks,
> Srinivas
> 

