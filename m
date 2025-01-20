Return-Path: <linux-acpi+bounces-10766-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DCBA173EC
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 22:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DFB3A8775
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 21:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D86D19597F;
	Mon, 20 Jan 2025 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzcZ1r8L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50117B421;
	Mon, 20 Jan 2025 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737407168; cv=none; b=FGNZTGOhzDIXvDMoKXbDLchdddMoPIVbCYcw/NyZ4/Uz28klaolFMwuSaQJ+yEkUKeran+9DdWsY0D507QBlZszMRENV2kug//DXzbkHj+P3eDFDtYf+nOBr3g8CLdj+vDbUbOfFURbqHrc4alfc06Jkm7tUc4PUE4goQ5nDaQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737407168; c=relaxed/simple;
	bh=GBh5P626QsGdi7oUY3CRFRMAwxOEdjn13i2ooVTVDII=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=liizlm6omMtlnXi3wyKaI+5AJZmR5qYBZaPyAtoirtacZVO1KjNvOssrzAZuxSDwQw2t44VSMdbGxtqmpd47gPsxY5m90LJZE2GSfa9HhYEmKNY30ZqVUVBVUMOnSjJKNTjsY42C53Uu0jdyRXKb5pcLIIaP4UTGBQm5utO7L4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzcZ1r8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C434AC4CEDD;
	Mon, 20 Jan 2025 21:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737407167;
	bh=GBh5P626QsGdi7oUY3CRFRMAwxOEdjn13i2ooVTVDII=;
	h=From:Date:Subject:To:Cc:From;
	b=SzcZ1r8L9fWZAZnDsahSBNNgHC/opY6X8cULhjgNPN0/QhA9oaYK9yVBP8ZFTpVUt
	 XmoFl+hHJaad5xxLHqilbumsGkrbI8WuDH7VVkB/3zhQKhI4tibgg/OigkNrhZiWT4
	 DjV6O9T+uxgLw3kyv69pUE8TiJWlPLGgRarGCzLhamTyHLbl/wKQ0Pm9keWUCb51F1
	 eETF7IgOx4NwugmNMA8fxpqbpRoJ8aJqjUKQqdjh3zz7gUDntnJlpeK+1mGi0Y8vPs
	 lHgki/1lSoI0k5LOrdmLUbcsgx7PNT55r5aZjAn6ES1dO76wN01eiM+DLcfOmeBZuZ
	 ep+ByTtqj83xw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5fa22d0b88fso2627031eaf.1;
        Mon, 20 Jan 2025 13:06:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUC8BD575wrlMdKZprwy+xJvTMVynySCbU/YH0cSIZ4+Rj2I0+vXTo0Xal+kSYtlnSImmagOZZNnOg=@vger.kernel.org, AJvYcCUchYvXhnH8FIuo7cpZmq1ymJU0iX8FoabsMQILavztBmGxMJ/LggqY/F3bKioCk7yS+v7hy8U7a91tPfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEDb8DMq9r3PHVuF71bHBnh/j3x9qnjFFLzUWzsYHRg4jY4g2K
	jo+aFS2309Jxx3D1kwNrGzWTZsErb9GIh89W/e53REICrucBrWqiaPc9knd78p4NyeU2trd7ALA
	Rra4uXfdORVUt8lQyWxNOopi37Vk=
X-Google-Smtp-Source: AGHT+IEEHSRA6U8aaZmHIbIgAXPkDGU5Qs9/u/CjOfi8Puaw/E4eHQVOQJLblx+xZTZULar302XjZuUslULpvr6Q52E=
X-Received: by 2002:a05:6820:8c3:b0:5f6:5596:b98a with SMTP id
 006d021491bc7-5fa388c0020mr9440233eaf.7.1737407167086; Mon, 20 Jan 2025
 13:06:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Jan 2025 22:05:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i66dR+grMVZpVM9a1kB5kVHcdiVdDk-9KPxRy2PmTv+w@mail.gmail.com>
X-Gm-Features: AbW1kvb4s47QSu3K7Jfs89iNzrqwYC20O7N1susDjqCMeFAUlfCjlrRji_7qBF0
Message-ID: <CAJZ5v0i66dR+grMVZpVM9a1kB5kVHcdiVdDk-9KPxRy2PmTv+w@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.14-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.14-rc1

with top-most commit d1ddf94665c6805a63659ab0b09ef626ecc2b0b2

 Merge branches 'acpi-battery', 'acpi-fan' and 'acpi-misc'

on top of commit 14578923e8c251091d2bb8a2756cde3b662ac316

 ACPI: video: Fix random crashes due to bad kfree()

to receive ACPI updates for 6.14-rc1.

The most significant change here is replacing msleep() in acpi_os_sleep()
with usleep_range() to reduce spurious sleep time due to timer inaccuracy
which may spectacularly reduce the duration of system suspend and resume
transitions on some systems.

All of the other changes fall into the fixes and cleanups category this
time.

Specifics:

 - Use usleep_range() instead of msleep() in acpi_os_sleep() to reduce
   excessive delays due to timer inaccuracy, mostly affecting system
   suspend and resume (Rafael Wysocki).

 - Use str_enabled_disabled() string helpers in the ACPI tables parsing
   code to make it easier to follow (Sunil V L).

 - Update device properties parsing on systems using ACPI so that
   data firmware nodes resulting from _DSD evaluation are treated
   as available in firmware nodes walks (Sakari Ailus).

 - Fix missing guid_t declaration in linux/prmt.h (Robert Richter).

 - Update the GHES handling code to follow the global panic=3D policy
   instead of overriding it by force-rebooting the system after a
   fatal HW error has been reported (Borislav Petkov).

 - Update messages printed by the ACPI battery driver to always
   refer to driver extensions as "hooks" to avoid confusion with
   similar functionality in the power supply subsystem in the
   future (Thomas Wei=C3=9Fschuh).

 - Fix .probe() error path cleanup in the ACPI fan driver to avoid
   memory leaks (Joe Hattori).

 - Constify 'struct bin_attribute' in some places in the ACPI subsystem
   and mark it as __ro_after_init in one place to prevent binary blob
   attributes from being updated (Thomas Wei=C3=9Fschuh)

 - Add empty stubs for several ACPI-related symbols so that they can be
   used when CONFIG_ACPI is unset and use them for removing unnecessary
   conditional compilation from the ipu-bridge driver (Ricardo Ribalda).

Thanks!


---------------

Borislav Petkov (1):
      APEI: GHES: Have GHES honor the panic=3D setting

Joe Hattori (1):
      ACPI: fan: cleanup resources in the error path of .probe()

Rafael J. Wysocki (1):
      ACPI: OSL: Use usleep_range() in acpi_os_sleep()

Ricardo Ribalda (7):
      ACPI: bus: change the prototype for acpi_get_physical_device_location
      ACPI: bus: implement for_each_acpi_dev_match when !ACPI
      ACPI: bus: implement acpi_get_physical_device_location when !ACPI
      ACPI: header: implement acpi_device_handle when !ACPI
      ACPI: bus: implement for_each_acpi_consumer_dev when !ACPI
      ACPI: bus: implement acpi_device_hid when !ACPI
      media: ipu-bridge: Remove unneeded conditional compilations

Robert Richter (1):
      ACPI: PRM: Fix missing guid_t declaration in linux/prmt.h

Sakari Ailus (1):
      ACPI: property: Consider data nodes as being available

Sunil V L (1):
      ACPI: tables: Use string choice helpers

Thomas Wei=C3=9Fschuh (4):
      ACPI: BGRT: Mark bin_attribute as __ro_after_init
      ACPI: BGRT: Constify 'struct bin_attribute'
      ACPI: sysfs: Constify 'struct bin_attribute'
      ACPI: battery: Rename extensions to hook in messages

---------------

 drivers/acpi/apei/ghes.c             | 10 +++++-----
 drivers/acpi/battery.c               | 14 +++++++-------
 drivers/acpi/bgrt.c                  |  6 +++---
 drivers/acpi/fan_core.c              | 10 ++++++++--
 drivers/acpi/mipi-disco-img.c        |  3 +--
 drivers/acpi/osl.c                   | 22 +++++++++++++++++++++-
 drivers/acpi/property.c              |  2 +-
 drivers/acpi/scan.c                  |  4 +---
 drivers/acpi/sysfs.c                 |  8 ++++----
 drivers/acpi/tables.c                | 12 ++++++------
 drivers/acpi/utils.c                 |  7 +++----
 drivers/base/physical_location.c     |  4 +---
 drivers/media/pci/intel/ipu-bridge.c | 29 ++++-------------------------
 drivers/usb/core/usb-acpi.c          |  3 +--
 include/acpi/acpi_bus.h              | 23 ++++++++++++++++++++---
 include/linux/acpi.h                 |  5 +++++
 include/linux/prmt.h                 |  2 ++
 17 files changed, 93 insertions(+), 71 deletions(-)

