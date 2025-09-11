Return-Path: <linux-acpi+bounces-16656-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C56FB52CC0
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 11:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4942C7A5D74
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 09:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45912E8B9D;
	Thu, 11 Sep 2025 09:11:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677202E7F02;
	Thu, 11 Sep 2025 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581917; cv=none; b=IgD68BNt/86GGA6wpAitiMcVU0bxxYY8jz69Z4SOwMboODvNAVPEZuClte9B5tFbeBpBTyTvvTe3YtuC+sWncq/JhdCtxCpkplCrbbPCdJYk5HZU4PqpGUrhVm8Za0f6uDX7rZZACE5W4DHoF802ETWJaVmbS12c978GWyrCtog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581917; c=relaxed/simple;
	bh=JpZBDBeKFOKzO+Oxv9nxvig4ZFN8i+yjFK9KZNu4CYA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbbhpLb+LpL548ix+8r5cCk42Y2Li0YU8QIwRoSrn8IDQ5xua2W4A6Moo6Zs2DFoHvBo0arUCVxp11IaQWbgWjrGD3aRrwxaMNUBTKBCVU/d20NxwPLtnJJqLzzjveBR5wAOiSZjbnY779rZvhQukZemFYwO3K8YDgsvERdCzg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cMsDz0ybLz6LD55;
	Thu, 11 Sep 2025 17:09:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C491D1400D3;
	Thu, 11 Sep 2025 17:11:46 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Sep
 2025 11:11:46 +0200
Date: Thu, 11 Sep 2025 10:11:44 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<andrew@kernel.org>, <bfaccini@nvidia.com>, <eahariha@linux.microsoft.com>,
	<dan.j.williams@intel.com>, <thorsten.blum@linux.dev>, <gourry@gourry.net>,
	<nunodasneves@linux.microsoft.com>, <wangyuquan1236@phytium.com.cn>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
Subject: Re: [PATCH] acpi,srat: Fix incorrect device handle check for
 Generic Initiator
Message-ID: <20250911101144.00001a84@huawei.com>
In-Reply-To: <998939f5-e0f9-457f-98a2-73f687ad29cc@linux.alibaba.com>
References: <20250910093949.5793-1-xueshuai@linux.alibaba.com>
	<20250910105729.000070a5@huawei.com>
	<998939f5-e0f9-457f-98a2-73f687ad29cc@linux.alibaba.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 11 Sep 2025 12:28:00 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> =E5=9C=A8 2025/9/10 17:57, Jonathan Cameron =E5=86=99=E9=81=93:
> > On Wed, 10 Sep 2025 17:39:49 +0800
> > Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> >  =20
> >> The Generic Initiator Affinity Structure in SRAT table uses device
> >> handle type field to indicate the device type. According to ACPI
> >> specification, the device handle type value of 1 represents PCI device,
> >> not 0.
> >>
> >> Fix this by defining explicit macros for device handle types and using
> >> the correct check for PCI devices:
> >>
> >> - ACPI_SRAT_ACPI_DEVICE_HANDLE (0): ACPI device handle
> >> - ACPI_SRAT_PCI_DEVICE_HANDLE (1): PCI device handle
> >>
> >> Fixes: 894c26a1c274 ("ACPI: Support Generic Initiator only domains")
> >> Reported-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> >> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com> =20
> >=20
> > The actbl3.h additions need to go through acpcia and then have a link
> > tag in here to show that it was merged.  Perhaps just fix it with a num=
ber
> > for now and follow up with the acpcia stuff in the longer run? =20
>=20
> Sure, I will drop changes in actbl3.h to make it easy to progress.
>=20
> >=20
> > Also note clearly this only affects a debug print - no functional bug.
> > That may change whether people choose to backport this or not. =20
>=20
> Yes.
>=20
> >=20
> > I'm curious on whether you are thinking of wiring this up so that
> > we can set the appropriate nodes on PCI Devices other than by doing it
> > with _PXM().  For obscure reasons there can be references both ways
> > (so DSDT Device entry -> SRAT via _PXM, and SRAT -> Device via this fie=
ld
> > of generic initiators).
> >=20
> > For now we only implement the first one so all we need is a node to be
> > instantiated for the GI to sit in.
> >=20
> > Come to think of it the fix that made PCI device entries in DSDT with _=
PXM
> > turn up in the right place was reverted (for a problem with broken firm=
ware
> > on AMD threadripper systems - IIRC that I think is long solved).
> > Not sure if that path even works today and the one this code is about h=
as
> > never been hooked up. =20
>=20
> You mean add a new map like pxm_to_node_map[]?
>
=20
Two things involved here. If a _PXM entry exists for the PCI device, then u=
nreverting:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D0d76bcc960e6057750fcf556b65da13f8bbdfd2b
or something to replace that is needed.  There may still be a problem somew=
here
as we never entirely figured out the cause last time.  It is also possible =
this got
fixed via another method in the meantime so first thing to do is to put som=
e devices
in a GI only node and see if the numa node value in sysfs is correct.

For the entry you are touching here to be passed to the actual set_dev_node=
() we'd
probably do it by stashing any GI entries found when parsing SRAT in an xar=
ray or similar and
adding a lookup to see if we have a match in that xarray but not a _PXM in =
pci_acpi_setup().

Not particularly hard to do, but have to be very careful wrt to broken bios=
 descriptions
of the topologies.=20

Jonathan


> >=20
> > Thanks for the fix!
> >=20
> > Jonathan
> >=20
> >  =20
>=20
> Thanks.
>=20
> Best Regards,
> Shuai


