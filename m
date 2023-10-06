Return-Path: <linux-acpi+bounces-479-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE257BBCE0
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 18:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF371C208A3
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF2528E07
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51C827EE9
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 15:37:10 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A1FAD;
	Fri,  6 Oct 2023 08:37:09 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-57c0775d4fcso300522eaf.0;
        Fri, 06 Oct 2023 08:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696606628; x=1697211428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeiMAtv5AttZMiFWoEeZzJ9dX67zb4cjF0O+jgyO5Xc=;
        b=TyvPEEgmOTp2cFhXzI4DAn3kAWA3iZ9zp5tA1PRZLOdwvru34b+2rKG/BR5ONHhXDd
         JuLlxqnpCYJdXVPvnLAT0Ezpw8jfWzx6Mq9mkut4FiKft+RBQyMtAjORtXk1DIVhuwEA
         3Zzsq08gCUs24EWen156Gn1fkHQf/fkUp2kSZHNkeCUwT5SXDSblToX5lpGUimqfYIpk
         4QE7KtRFR3YQAMTHjIN79hI5ijyQTFzH24PUVPJ4rYfENfLzBlDwjH2bzwT+QSaBX8AI
         XwzBD60yb4zlLT0MX8UejP1DLm37xNAsMvZsVvTDcgz9olAxuXxj38vLoVU4xlOjPdA3
         SXDg==
X-Gm-Message-State: AOJu0YyHCdOtnTNcGFVLCWFrmo5+9qoO91Xsj5Plp1vXQc+XPnzF143A
	ey/qLDgQ18NvvecUtzvV/5AWQ4cEQzStSrfeBY0=
X-Google-Smtp-Source: AGHT+IH4D47AdeFdsjtNMg89YyGOipLpM5WP95sBMmF0AqVHXMLm2atpiWD4455Q/8EyDaeKLBsTAdbXkjryyEsJzr4=
X-Received: by 2002:a4a:de08:0:b0:56e:94ed:c098 with SMTP id
 y8-20020a4ade08000000b0056e94edc098mr8247641oot.0.1696606628539; Fri, 06 Oct
 2023 08:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
 <20230925144842.586829-3-michal.wilczynski@intel.com> <2725050.mvXUDI8C0e@kreacher>
 <edb1d4bc-a484-42ea-9a5c-4c77a860645a@intel.com> <04972447-91b5-4392-acf0-c942e02403c2@intel.com>
In-Reply-To: <04972447-91b5-4392-acf0-c942e02403c2@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Oct 2023 17:36:57 +0200
Message-ID: <CAJZ5v0h3ZggWKAuKDbFnPbhWpcwnDVk+OrBPRsahM87_H=ob1A@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] docs: firmware-guide: ACPI: Clarify ACPI bus concepts
To: "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com, lenb@kernel.org, 
	dan.j.williams@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com, 
	rui.zhang@intel.com, Elena Reshetova <elena.reshetova@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 10:39=E2=80=AFPM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
>
>
> On 10/5/2023 8:28 PM, Wilczynski, Michal wrote:
> >
> > On 10/5/2023 7:57 PM, Rafael J. Wysocki wrote:
> >> On Monday, September 25, 2023 4:48:35 PM CEST Michal Wilczynski wrote:
> >>> Some devices implement ACPI driver as a way to manage devices
> >>> enumerated by the ACPI. This might be confusing as a preferred way to
> >>> implement a driver for devices not connected to any bus is a platform
> >>> driver, as stated in the documentation. Clarify relationships between
> >>> ACPI device, platform device and ACPI entries.
> >>>
> >>> Suggested-by: Elena Reshetova <elena.reshetova@intel.com>
> >>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> >>> ---
> >>>  Documentation/firmware-guide/acpi/enumeration.rst | 13 +++++++++++++
> >>>  1 file changed, 13 insertions(+)
> >>>
> >>> diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Docu=
mentation/firmware-guide/acpi/enumeration.rst
> >>> index 56d9913a3370..f56cc79a9e83 100644
> >>> --- a/Documentation/firmware-guide/acpi/enumeration.rst
> >>> +++ b/Documentation/firmware-guide/acpi/enumeration.rst
> >>> @@ -64,6 +64,19 @@ If the driver needs to perform more complex initia=
lization like getting and
> >>>  configuring GPIOs it can get its ACPI handle and extract this inform=
ation
> >>>  from ACPI tables.
> >>>
> >>> +ACPI bus
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +Historically some devices not connected to any bus were represented =
as ACPI
> >>> +devices, and had to implement ACPI driver. This is not a preferred w=
ay for new
> >>> +drivers. As explained above devices not connected to any bus should =
implement
> >>> +platform driver. ACPI device would be created during enumeration non=
etheless,
> >>> +and would be accessible through ACPI_COMPANION() macro, and the ACPI=
 handle would
> >>> +be accessible through ACPI_HANDLE() macro. ACPI device is meant to d=
escribe
> >>> +information related to ACPI entry e.g. handle of the ACPI entry. Thi=
nk -
> >>> +ACPI device interfaces with the FW, and the platform device with the=
 rest of
> >>> +the system.
> >>> +
> >>>  DMA support
> >>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> I rewrote the above entirely, so here's a new patch to replace this on=
e:
> >>
> >> ---
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Subject: [PATCH v2 2/9] ACPI: docs: enumeration: Clarify ACPI bus conc=
epts
> >>
> >> In some cases, ACPI drivers are implemented as a way to manage devices
> >> enumerated with the help of the platform firmware through ACPI.
> >>
> >> This might be confusing, since the preferred way to implement a driver
> >> for a device that cannot be enumerated natively, is a platform
> >> driver, as stated in the documentation.
> >>
> >> Clarify relationships between ACPI device objects, platform devices an=
d
> >> ACPI Namespace entries.
> >>
> >> Suggested-by: Elena Reshetova <elena.reshetova@intel.com>
> >> Co-developed-by: Michal Wilczynski <michal.wilczynski@intel.com>
> >> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> ---
> >>  Documentation/firmware-guide/acpi/enumeration.rst |   43 ++++++++++++=
++++++++++
> >>  1 file changed, 43 insertions(+)
> >>
> >> Index: linux-pm/Documentation/firmware-guide/acpi/enumeration.rst
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> --- linux-pm.orig/Documentation/firmware-guide/acpi/enumeration.rst
> >> +++ linux-pm/Documentation/firmware-guide/acpi/enumeration.rst
> >> @@ -64,6 +64,49 @@ If the driver needs to perform more comp
> >>  configuring GPIOs it can get its ACPI handle and extract this informa=
tion
> >>  from ACPI tables.
> >>
> >> +ACPI device objects
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +Generally speaking, there are two categories of devices in a system i=
n which
> >> +ACPI is used as an interface between the platform firmware and the OS=
: Devices
> >> +that can be discovered and enumerated natively, through a protocol de=
fined for
> >> +the specific bus that they are on (for example, configuration space i=
n PCI),
> >> +without the platform firmware assistance, and devices that need to be=
 described
> >> +by the platform firmware so that they can be discovered.  Still, for =
any device
> >> +known to the platform firmware, regardless of which category it falls=
 into,
> >> +there can be a corresponding ACPI device object in the ACPI Namespace=
 in which
> >> +case the Linux kernel will create a struct acpi_device object based o=
n it for
> >> +that device.
> >> +
> >> +Those struct acpi_device objects are never used for binding drivers t=
o natively
> >> +discoverable devices, because they are represented by other types of =
device
> >> +objects (for example, struct pci_dev for PCI devices) that are bound =
to by
> >> +device drivers (the corresponding struct acpi_device object is then u=
sed as
> >> +an additional source of information on the configuration of the given=
 device).
> >> +Moreover, the core ACPI device enumeration code creates struct platfo=
rm_device
> >> +objects for the majority of devices that are discovered and enumerate=
d with the
> >> +help of the platform firmware and those platform device objects can b=
e bound to
> >> +by platform drivers in direct analogy with the natively enumerable de=
vices
> >> +case.  Therefore it is logically inconsistent and so generally invali=
d to bind
> >> +drivers to struct acpi_device objects, including drivers for devices =
that are
> >> +discovered with the help of the platform firmware.
> >> +
> >> +Historically, ACPI drivers that bound directly to struct acpi_device =
objects
> >> +were implemented for some devices enumerated with the help of the pla=
tform
> >> +firmware, but this is not recommended for any new drivers.  As explai=
ned above,
> >> +platform device objects are created for those devices as a rule (with=
 a few
> >> +exceptions that are not relevant here) and so platform drivers should=
 be used
> >> +for handling them, even though the corresponding ACPI device objects =
are the
> >> +only source of device configuration information in that case.
> >> +
> >> +For every device having a corresponding struct acpi_device object, th=
e pointer
> >> +to it is returned by the ACPI_COMPANION() macro, so it is always poss=
ible to
> >> +get to the device configuration information stored in the ACPI device=
 object
> >> +this way.  Accordingly, struct acpi_device can be regarded as a part =
of the
> >> +interface between the kernel and the ACPI Namespace, whereas device o=
bjects of
> >> +other types (for example, struct pci_dev or struct platform_device) a=
re used
> >> +for interacting with the rest of the system.
> >> +
> >>  DMA support
> >>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Thanks a lot !
> > Looks very good, will include this in next revision.
> >
> > Micha=C5=82
>
> Aww, forgot that you can also just apply it yourself, so I can just fetch=
 and
> rebase. Whichever version you prefer is fine with me :-)

So I went ahead and queued up my versions of patches [1-2/9].  They
are present in the acpi-bus branch in linux-pm.git (based on 6.6-rc4)
and in the bleeding-edge branch (I'll merge acpi-bus into linux-next
next week if all goes well).

