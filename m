Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DA0433C4F
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Oct 2021 18:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhJSQfd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Oct 2021 12:35:33 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:34482 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbhJSQfc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Oct 2021 12:35:32 -0400
Received: by mail-oi1-f169.google.com with SMTP id v77so5824862oie.1;
        Tue, 19 Oct 2021 09:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=calD69s3n0A0Akzhy4zGGZahx+TFdeC7vroqt57K+Uk=;
        b=uVrXah/yFODlQZODBxTGjhvxytSdlGJeDyGr5E7OP6qPWcBKIZQ9w3PzY3LwIlUStE
         quAeJY3kwi/BHd5vzjJpSddwuCx1PquM89eq+mfNLja9UCLkTOBxro60HkcxH2+FIkPV
         PlE34HdRUsUfUXs5atMCk3uDWwabOWrzZre2yE93MX6RV+EJ9rR9tVQLDg4k508ISWm+
         eCR0vCL2mv751F1ow48DHPHQTabuGp0pTVFU1EzdIgfZb6f+aK6qQqBCLldErKwrp/Vc
         dwxl/76ET4ly2izWuFMVQYeNoeXT/wuzOMYOg4zHT6gHskR++NqtIQkxPfASJE/kb43c
         ZZ/w==
X-Gm-Message-State: AOAM533YLf8TWQsMBNWrF6wS+SxEYxy1uE1tkOYmsXI7rGQuelUP3wO9
        kNsWEUdtYiuSB1svegWatlUXKFDByMSql6ezE0YYuWL7pWA=
X-Google-Smtp-Source: ABdhPJx/X1qAjNMigq3LftdhwEBF4GtlfTe9w1Y0I97dKV4ORu9LJ/tqE4/sV8qfTLMyiFQbPWHTyDxhABztk5lnTJg=
X-Received: by 2002:aca:b5c3:: with SMTP id e186mr5212314oif.51.1634661199210;
 Tue, 19 Oct 2021 09:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634310710.git.yu.c.chen@intel.com> <eadc25933400c71a52e7d176880df09a147a39b9.1634310710.git.yu.c.chen@intel.com>
 <YWrswQ+ETMthZZVk@kroah.com>
In-Reply-To: <YWrswQ+ETMthZZVk@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Oct 2021 18:33:08 +0200
Message-ID: <CAJZ5v0gvLDu8xGUVR0kATko8M37RiYg63t+1BWFox499QJxSpg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Oct 16, 2021 at 5:16 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Oct 16, 2021 at 06:40:51PM +0800, Chen Yu wrote:
> > Introduce the pfru_update driver which can be used for Platform Firmware
> > Runtime code injection and driver update[1]. The user is expected to
> > provide the update firmware in the form of capsule file, and pass it to
> > the driver via ioctl. Then the driver would hand this capsule file to the
> > Platform Firmware Runtime Update via the ACPI device _DSM method. At last
> > the low level Management Mode would do the firmware update.
> >
> > [1] https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf
> >
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> > v4: Add Documentation/ABI/testing/pfru (Rafael J. Wysocki)
> >     Change all pr_debug() to dev_dbg() (Greg Kroah-Hartman,
> >     Rafael J. Wysocki)
> >     Change the error code ENOIOCTLCMD to ENOTTY in ioctl.
> >     (Greg Kroah-Hartman)
> >     Remove compat ioctl. (Greg Kroah-Hartman)
> >     Change /dev/pfru/update to /dev/acpi_pfru (Greg Kroah-Hartman)
> >     Remove valid_cap_type() and do sanity check in query_capability().
> >     (Rafael J. Wysocki)
> >     Remove the loop in query_capability().
> >     (Rafael J. Wysocki)
> >     Do not fail if the package has more elements than expected,
> >     and return error if the number of package elements is too
> >     small. (Rafael J. Wysocki)
> >     Return the type or a negative error code in get_image_type()
> >     (Rafael J. Wysocki)
> >     Put the comment inside the function rather than outside.
> >     (Rafael J. Wysocki)
> >     Return the size or a negative error code adjust_efi_size()
> >     (Rafael J. Wysocki)
> >     Return -EINVAL rather than -EFAULT if revison id is incorrect.
> >     (Rafael J. Wysocki)
> >     Move the an read() of pfru into ioctl(), and using read() for
> >     the telemetry retrieval. So as to avoid the telemetry device
> >     file, the write() will be the code injection/update, the read()
> >     will be telemetry retrieval and all of the rest can be ioctl()s
> >     under one special device file.
> >     (Rafael J. Wysocki)
> > v3: Use __u32 instead of int and __64 instead of unsigned long
> >     in include/uapi/linux/pfru.h (Greg Kroah-Hartman)
> >     Rename the structure in uapi to start with a prefix pfru so as
> >     to avoid confusing in the global namespace. (Greg Kroah-Hartman)
> > v2: Add sanity check for duplicated instance of ACPI device.
> >     Update the driver to work with allocated pfru_device objects.
> >     (Mike Rapoport)
> >     For each switch case pair, get rid of the magic case numbers
> >     and add a default clause with the error handling.
> >     (Mike Rapoport)
> >     Move the obj->type checks outside the switch to reduce redundancy.
> >     (Mike Rapoport)
> >     Parse the code_inj_id and drv_update_id at driver initialization time
> >     to reduce the re-parsing at runtime.(Mike Rapoport)
> >     Explain in detail how the size needs to be adjusted when doing
> >     version check.(Mike Rapoport)
> >     Rename parse_update_result() to dump_update_result()(Mike Rapoport)
> >     Remove redundant return.(Mike Rapoport)
> >     Do not expose struct capsulate_buf_info to uapi, since it is
> >     not needed in userspace.(Mike Rapoport)
> > ---
> >  Documentation/ABI/testing/pfru                |  41 ++
> >  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
> >  drivers/acpi/Kconfig                          |   1 +
> >  drivers/acpi/Makefile                         |   1 +
> >  drivers/acpi/pfru/Kconfig                     |  16 +
> >  drivers/acpi/pfru/Makefile                    |   2 +
> >  drivers/acpi/pfru/pfru_update.c               | 567 ++++++++++++++++++
> >  include/uapi/linux/pfru.h                     | 102 ++++
> >  8 files changed, 731 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/pfru
> >  create mode 100644 drivers/acpi/pfru/Kconfig
> >  create mode 100644 drivers/acpi/pfru/Makefile
> >  create mode 100644 drivers/acpi/pfru/pfru_update.c
> >  create mode 100644 include/uapi/linux/pfru.h
> >
> > diff --git a/Documentation/ABI/testing/pfru b/Documentation/ABI/testing/pfru
> > new file mode 100644
> > index 000000000000..b8bc81703f46
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/pfru
> > @@ -0,0 +1,41 @@
> > +What:                /dev/acpi_pfru
> > +Date:                October 2021
> > +KernelVersion:       5.15
> > +Contact:     Chen Yu <yu.c.chen@intel.com>
> > +Description:
> > +             The ioctl interface to drivers for platform firmware runtime
> > +             update(PFRU). Following actions are supported:
> > +
> > +             * PFRU_IOC_QUERY_CAP: Read the PFRU Runtime Update capability.
> > +               The value is a structure of pfru_update_cap_info.
> > +               See include/uapi/linux/pfru.h for definition.
> > +
> > +             * PFRU_SET_REV: Set the Revision ID for PFRU Runtime Update.
> > +               It could be either 1 or 2.
> > +
> > +             * PFRU_IOC_STAGE: Stage a capsule image from communication
> > +               buffer and perform authentication.
> > +
> > +             * PFRU_IOC_ACTIVATE: Activate a previous staged capsule image.
> > +
> > +             * PFRU_IOC_STAGE_ACTIVATE: Perform both stage and activation
> > +               actions.
> > +
> > +             * PFRU_LOG_IOC_SET_INFO: set log information in Telemetry
> > +               Service. The input is a structure of pfru_log_info.
> > +               This structure includes log revision id(1 or 2),
> > +               log level(0 : Error Message, 1 : Warning Message,
> > +               2 : Informational Message, 4 : Verbose), log data type
> > +               (0 : Execution Log, 1 : History Information).
> > +               See include/uapi/linux/pfru.h for definition.
> > +
> > +             * PFRU_LOG_IOC_GET_INFO: get log information in Telemetry.
> > +               The output is a structure of pfru_log_info.
> > +
> > +             * PFRU_LOG_IOC_GET_DATA_INFO: get log data information in
> > +               Telemetry. The output is a structure of pfru_log_data_info.
> > +               See include/uapi/linux/pfru.h for definition.
> > +
> > +             Besides ioctl interface, write() and read() are supported on
> > +             /dev/acpi_pfru. The write() will be the code injection/update,
> > +             and the read() will be telemetry retrieval.
>
> Do we normally describe ioctl interfaces in Documentation/ABI/?  Why not
> just add this to the kernel doc with the structures you are creating?
> Wouldn't that be easier?

It would work I suppose.

> Or are other acpi ioctl interfaces documented here already?

No, they aren't, but there is Documentation/ABI/testing/gpio-cdev, for
example, so there is some practice there.  Whether it is good or bad
is a separate topic though.
