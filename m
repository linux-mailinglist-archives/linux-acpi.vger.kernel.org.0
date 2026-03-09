Return-Path: <linux-acpi+bounces-21554-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIPxK/bvrmmFKgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21554-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 17:06:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB9323C6B4
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 17:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FA653021719
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 16:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86203DA7D9;
	Mon,  9 Mar 2026 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXgXZ9rD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A306E3D34B2;
	Mon,  9 Mar 2026 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072087; cv=none; b=utRsmQZr84OE2jj1iYNIu3ud/EVgbhpoUVmsTPqAIzYuyBGqIutFmD9c4k6Gfs+W3CddW1EExQoXnjknP61M/ho+geBvP+mVkyoWpIreb09XRWIpyUaPjdFG5UEMx0TQJg94tgGpn4/770ELT476jwUXmZK6BZ9tgKYi93PeDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072087; c=relaxed/simple;
	bh=NkX+2F9kzFhlpKI9V32BdvjxTVfhDUFhekefMZMGEcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMdAgPaTYif2c5/XCRf33GzDMH8ZSsYdqymgxV5T4D7HtvNUUMD5H0Tn4ZvadM1biEAudOo+XTnMg9/gpWlN81u9Gp7MfcIJHqecs0hGBg143APOcycxoMU6lsu8JFj/JAFA5heFcLsOAoOGz2KHALMPFzyq4MUm0kq+nF1dREA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXgXZ9rD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E327C4CEF7;
	Mon,  9 Mar 2026 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773072087;
	bh=NkX+2F9kzFhlpKI9V32BdvjxTVfhDUFhekefMZMGEcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXgXZ9rDgfpvKWZQsTTwe8tPKQVB3hGdiBicwLy1PUvv3elc2WThGz8szXad/ioNV
	 iH68fVbXZXJAaVHFk30EqS39+352MovuRlcs8mrczVVYZcLvsRUjXaE0m+XwwITRe1
	 Iq14Ja7yygeWIPqWqNUMysnQcDRTTUvhWcFv46cyPp0LaePbSH0QBpvCfmMJoJ0Dqw
	 ZyKfW1HWGiaPIHpQT1/GHRj2Z5FhpBPNcUQPkPLPVe0lxShwKLSEoYx4++Tlt9fSAM
	 TA80BoZ+Vrfzvm3QDbAbE0nB6qpq0cPgVlR0wr4xlq5KPkwS8hQRtuYmcG8ZVcQixl
	 To7iEDMwryaKw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: "Nirujogi, Pratap" <pnirujog@amd.com>
Cc: "Du, Bin" <bin.du@amd.com>, Mario Limonciello <superm1@kernel.org>,
 W_Armin@gmx.de, benjamin.chan@amd.com, king.li@amd.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: [PATCH v1] ACPI: video: Switch over to auxiliary bus type
Date: Mon, 09 Mar 2026 17:01:21 +0100
Message-ID: <5982633.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0gR+-Y=XqNXoBrUpd9HtSRqGk2cSXBgXsp5YJRsdCTMTg@mail.gmail.com>
References:
 <007e3390-6b2b-457e-83c7-c794c5952018@amd.com>
 <CAJZ5v0iNdTFExoupRmwJmdykdRJa1QUJXzsb+j4M1cpn1qALig@mail.gmail.com>
 <CAJZ5v0gR+-Y=XqNXoBrUpd9HtSRqGk2cSXBgXsp5YJRsdCTMTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 3AB9323C6B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,gmx.de,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-21554-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

On Monday, March 9, 2026 1:23:35 PM CET Rafael J. Wysocki wrote:
> On Mon, Mar 9, 2026 at 12:58=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Mon, Mar 9, 2026 at 9:11=E2=80=AFAM Du, Bin <bin.du@amd.com> wrote:
> > >
> > >
> > >
> > > On 3/9/2026 11:52 AM, Nirujogi, Pratap wrote:
> > > >
> > > >
> > > > On 3/6/2026 7:45 AM, Mario Limonciello wrote:
> > > >> Caution: This message originated from an External Source. Use prop=
er
> > > >> caution when opening attachments, clicking links, or responding.
> > > >>
> > > >>
> > > >> On 3/6/26 6:01 AM, Rafael J. Wysocki wrote:
> > > >>> On Fri, Mar 6, 2026 at 1:35=E2=80=AFAM Mario Limonciello (AMD) (k=
ernel.org)
> > > >>> <superm1@kernel.org> wrote:
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>> On 3/5/2026 5:11 PM, Nirujogi, Pratap wrote:
> > > >>>>> Hi Rafael,
> > > >>>>>
> > > >>>>> In kernel version 7.0-rc2, the AMDISP device reports the follow=
ing
> > > >>>>> errors when created via mfd_add_hotplug_devices.
> > > >>>>>
> > > >>>>> [    5.236645] ACPI: video: Video Device [GFX0] (multi-head: ye=
s  rom:
> > > >>>>> no  post: no)
> > > >>>>> [    5.236744] input: Video Bus as /devices/
> > > >>>>> pci0000:00/0000:00:08.1/0000:c3:00.0/amd_isp_capture.1.auto/inp=
ut/
> > > >>>>> input21
> > > >>>>> [    5.236779] acpi device:14: Error installing notify handler
> > > >>>>> [    5.236782] acpi device:15: Error installing notify handler
> > > >>>>> [    5.236783] acpi device:16: Error installing notify handler
> > > >>>>> [    5.236784] acpi device:17: Error installing notify handler
> > > >>>>> [    5.236785] acpi device:18: Error installing notify handler
> > > >>>>> [    5.236786] acpi device:19: Error installing notify handler
> > > >>>>> [    5.236786] acpi device:1a: Error installing notify handler
> > > >>>>> [    5.236787] acpi device:1b: Error installing notify handler
> > > >>>>> [    5.236788] acpi device:1c: Error installing notify handler
> > > >>>>>
> > > >>>>> These failures indicate AMDISP device is incorrectly detected a=
s ACPI
> > > >>>>> Video device while it is not.
> > > >>>>>
> > > >>>>> The seems like a regression caused by the change that converts =
the
> > > >>>>> ACPI
> > > >>>>> video device to a platform device (commit: 02c057ddefef5).
> > > >>>>>
> > > >>>>> Issue is not observed in 6.19-rc6, and also when this change is
> > > >>>>> reverted
> > > >>>>> in 7.0-rc2.
> > > >>>>>
> > > >>>>> I really appreciate your inputs on addressing this issue and
> > > >>>>> helping us
> > > >>>>> make progress on 7.0 rc2.
> > > >>>>>
> > > >>>>> Steps followed to reproduce the issue:
> > > >>>>>
> > > >>>>> 1. Apply AMDISP v9 patch series [1] on top of kernel v7.0-rc2
> > > >>>>> 2. Add NULL check for =E2=80=9Cdev->type=E2=80=9D in isp_genpd_=
add_device() [2] (to
> > > >>>>> avoid kernel panic found in v7.0-rc2)
> > > >>>>> 3. Build kernel with:
> > > >>>>>       - CONFIG_AMD_ISP_PLATFORM=3Dy
> > > >>>>>       - CONFIG_VIDEO_AMD_ISP4_CAPTURE=3Dm
> > > >>>>> 4. Install kernel on AMDISP supported system (HP ZBook Ultra G1=
a)
> > > >>>>> 5. Boot system to see the failures
> > > >>>>>
> > > >>>>> [1] https://lore.kernel.org/all/20260302073020.148277-1-
> > > >>>>> Bin.Du@amd.com/
> > > >>>>> [2] https://github.com/torvalds/linux/blob/master/drivers/gpu/d=
rm/amd/
> > > >>>>> amdgpu/isp_v4_1_1.c#L132
> > > >>>>>
> > > >>>>> Thanks,
> > > >>>>> Pratap
> > > >>>>>
> > > >>>>>
> > > >>>>>
> > > >>>>
> > > >>>> It's a bit weird to see it even probe in this path in the first =
place.
> > > >>>> acpi_video_bus_probe() getting called with the mfd device doesn'=
t seem
> > > >>>> right to me.
> > > >>>>
> > > >>>> I wonder if it's because ISP is an MFD device of GPU (and thus L=
NXVIDEO
> > > >>>> ends up matching).
> > > >>>>
> > > >>>> Would a sensible solution be to reject mfd device types in
> > > >>>> acpi_video_bus_probe()?
> > > >>>
> > > >>> Every platform device with LNXVIDEO in the device ID list will be
> > > >>> matched and so probed.
> > > >>>
> > > >>> I'm wondering how those devices get that ID though.
> > > >>
> > > >> Yeah me too.  I was surprised an MFD device got it.
> > > >>
> > > >> Pratap - can you figure this out before we go too far in this path?
> > > >>
> > > > yes, MFD child devices in this case have the device ID as that of p=
arent
> > > > (GPU) i.e. LNXVIDEO. Its because when no acpi_match is specified, t=
he
> > > > MFD child devices are inheriting the parent's ACPI companion device=
 and
> > > > this is resulting in having the same parent's ACPI device ID.
> > > >
> > > > device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
> > > > https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.=
c#L91
> > > >
> > > >> If they really shouldn't have LNXVIDEO fixing that may be a better
> > > >> solution.
> > > >>
> > > > AMD ISP related MFD devices are using the same LNXVIDEO device ID e=
ven
> > > > on 6.19-rc4, no issues observed earlier. I can confirm automatic AM=
D ISP
> > > > device probe works and also camera works on 7.0-rc2 if I avoid
> > > > inheriting ACPI companion of the parent (GPU) in the mfd-core.c
> > > >
> > > > // device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
> > > > https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.=
c#L91
> > > >
> > > > But why this is an issue on 7.0-rc2 while it works on 6.19-rc4 need=
s to
> > > > be root caused.
> > > >
> > >
> > > Possible cause may be.
> > > 1. On 6.x (without commit 02c057ddefef5), the ACPI video driver was
> > > registered as an acpi_driver (static struct acpi_driver acpi_video_bu=
s)
> > > ,  it lives on the ACPI bus (acpi_bus_type). It only binds to struct
> > > acpi_device objects in the ACPI namespace. MFD children of GFX
> > > (amd_isp_capture, amd_isp_i2c_designware, amdisp-pinctrl) are platform
> > > devices on the platform bus, they are completely invisible to
> > > acpi_driver, so there is no chance of the ACPI video driver matching =
an
> > > MFD child.
> > > 2. On 7.0 (with commit 02c057ddefef5), the ACPI video driver was
> > > converted to a platform_driver (static struct platform_driver
> > > acpi_video_bus), it lives on the platform bus. When the kernel regist=
ers
> > > a new platform device, it checks ALL registered platform drivers to s=
ee
> > > if any match. The matching logic for acpi_match_table works like this:
> > > - Get the platform device's ACPI companion (ACPI_COMPANION(dev))
> > > - Check if the companion's HID/CID matches any entry in acpi_match_ta=
ble
> > > - If yes, the driver probes the device
> >
> > It does, but then the probe fails.  This is the problem that has been
> > reported to start with.
>=20
> I guess I know what's going on.
>=20
> Every device that shares an ACPI companion with the ACPI video bus
> device advertises itself as "LNXVIDEO", so udev looks for a module
> matching that device ID and since the ACPI video driver is loaded, it
> will not attempt to load anything else.
>=20
> It may be viable to use an auxiliary device for ACPI video bus device
> representation, let me have a look at that.

So appended is a patch that works for me.

Please test it and let me know if it helps.

=2D--
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] ACPI: video: Switch over to auxiliary bus type

Commit 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
switched over the ACPI video bus driver from an ACPI driver to a platform
driver, but that change introduced an unwanted and unexpected side effect.
Namely, on some systems, the ACPI device object of the ACPI video bus
device is an ACPI companion of multiple platform devices and, after
adding video_device_ids[] as an acpi_match_table to the acpi_video_bus
platform driver, all of those devices started to match that driver and
its probe callback is invoked for all of them (it fails, but it leaves
confusing message in the log).  Moreover, the MODULE_DEVICE_TABLE()
of the ACPI video driver module matches all of the devices sharing the
ACPI companion with the ACPI video bus device, so registering them does
not cause any other modules to be loaded, so they are only probed
against the ACPI video bus platform driver.

To address this, make the core ACPI device enumeration code create an
auxiliary device for the ACPI video bus device object instead of a
platform device and switch over the ACPI video bus driver (once again)
to an auxiliary driver.

Auxiliary driver generally is a better match for ACPI video bus than
platform driver, among other things because the ACPI video bus device
does not require any resources to be allocated for it during
enumeration.  It also allows the ACPI video bus driver to stop abusing
device matching based on ACPI device IDs and it allows a special case
to be dropped from acpi_create_platform_device() because that function
need not worry about the ACPI video bus device any more.

=46ixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/acpi/acpi_platform.c |    2 -
 drivers/acpi/acpi_video.c    |   45 ++++++++++++++++++++------------------=
=2D--
 drivers/acpi/scan.c          |   47 ++++++++++++++++++++++++++++++++++++++=
+++++
 3 files changed, 70 insertions(+), 24 deletions(-)

=2D-- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -135,7 +135,7 @@ struct platform_device *acpi_create_plat
 		}
 	}
=20
=2D	if (adev->device_type =3D=3D ACPI_BUS_TYPE_DEVICE && !adev->pnp.type.ba=
cklight) {
+	if (adev->device_type =3D=3D ACPI_BUS_TYPE_DEVICE) {
 		LIST_HEAD(resource_list);
=20
 		count =3D acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
=2D-- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -9,6 +9,7 @@
=20
 #define pr_fmt(fmt) "ACPI: video: " fmt
=20
+#include <linux/auxiliary_bus.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -21,7 +22,6 @@
 #include <linux/sort.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
=2D#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/dmi.h>
 #include <linux/suspend.h>
@@ -77,8 +77,9 @@ static int register_count;
 static DEFINE_MUTEX(register_count_mutex);
 static DEFINE_MUTEX(video_list_lock);
 static LIST_HEAD(video_bus_head);
=2Dstatic int acpi_video_bus_probe(struct platform_device *pdev);
=2Dstatic void acpi_video_bus_remove(struct platform_device *pdev);
+static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
+				const struct auxiliary_device_id *id);
+static void acpi_video_bus_remove(struct auxiliary_device *aux);
 static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *dat=
a);
=20
 /*
@@ -93,19 +94,16 @@ enum acpi_video_level_idx {
 	ACPI_VIDEO_FIRST_LEVEL,		/* actual supported levels begin here */
 };
=20
=2Dstatic const struct acpi_device_id video_device_ids[] =3D {
=2D	{ACPI_VIDEO_HID, 0},
=2D	{"", 0},
+static const struct auxiliary_device_id video_bus_auxiliary_id_table[] =3D=
 {
+	{ .name =3D "acpi.video_bus" },
+	{},
 };
=2DMODULE_DEVICE_TABLE(acpi, video_device_ids);
+MODULE_DEVICE_TABLE(auxiliary, video_bus_auxiliary_id_table);
=20
=2Dstatic struct platform_driver acpi_video_bus =3D {
+static struct auxiliary_driver acpi_video_bus =3D {
 	.probe =3D acpi_video_bus_probe,
 	.remove =3D acpi_video_bus_remove,
=2D	.driver =3D {
=2D		.name =3D "acpi-video",
=2D		.acpi_match_table =3D video_device_ids,
=2D	},
+	.id_table =3D video_bus_auxiliary_id_table,
 };
=20
 struct acpi_video_bus_flags {
@@ -1885,7 +1883,7 @@ static void acpi_video_dev_add_notify_ha
 }
=20
 static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *video,
=2D					     struct platform_device *pdev)
+					     struct device *parent)
 {
 	struct input_dev *input;
 	struct acpi_video_device *dev;
@@ -1908,7 +1906,7 @@ static int acpi_video_bus_add_notify_han
 	input->phys =3D video->phys;
 	input->id.bustype =3D BUS_HOST;
 	input->id.product =3D 0x06;
=2D	input->dev.parent =3D &pdev->dev;
+	input->dev.parent =3D parent;
 	input->evbit[0] =3D BIT(EV_KEY);
 	set_bit(KEY_SWITCHVIDEOMODE, input->keybit);
 	set_bit(KEY_VIDEO_NEXT, input->keybit);
@@ -1980,9 +1978,10 @@ static int acpi_video_bus_put_devices(st
=20
 static int instance;
=20
=2Dstatic int acpi_video_bus_probe(struct platform_device *pdev)
+static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
+				const struct auxiliary_device_id *id_unused)
 {
=2D	struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device =3D ACPI_COMPANION(&aux_dev->dev);
 	struct acpi_video_bus *video;
 	bool auto_detect;
 	int error;
@@ -2019,7 +2018,7 @@ static int acpi_video_bus_probe(struct p
 		instance++;
 	}
=20
=2D	platform_set_drvdata(pdev, video);
+	auxiliary_set_drvdata(aux_dev, video);
=20
 	video->device =3D device;
 	strscpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
@@ -2068,7 +2067,7 @@ static int acpi_video_bus_probe(struct p
 	    !auto_detect)
 		acpi_video_bus_register_backlight(video);
=20
=2D	error =3D acpi_video_bus_add_notify_handler(video, pdev);
+	error =3D acpi_video_bus_add_notify_handler(video, &aux_dev->dev);
 	if (error)
 		goto err_del;
=20
@@ -2096,10 +2095,10 @@ err_free_video:
 	return error;
 }
=20
=2Dstatic void acpi_video_bus_remove(struct platform_device *pdev)
+static void acpi_video_bus_remove(struct auxiliary_device *aux_dev)
 {
=2D	struct acpi_video_bus *video =3D platform_get_drvdata(pdev);
=2D	struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
+	struct acpi_video_bus *video =3D auxiliary_get_drvdata(aux_dev);
+	struct acpi_device *device =3D ACPI_COMPANION(&aux_dev->dev);
=20
 	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
 				       acpi_video_bus_notify);
@@ -2163,7 +2162,7 @@ int acpi_video_register(void)
=20
 	dmi_check_system(video_dmi_table);
=20
=2D	ret =3D platform_driver_register(&acpi_video_bus);
+	ret =3D auxiliary_driver_register(&acpi_video_bus);
 	if (ret)
 		goto leave;
=20
@@ -2183,7 +2182,7 @@ void acpi_video_unregister(void)
 {
 	mutex_lock(&register_count_mutex);
 	if (register_count) {
=2D		platform_driver_unregister(&acpi_video_bus);
+		auxiliary_driver_unregister(&acpi_video_bus);
 		register_count =3D 0;
 		may_report_brightness_keys =3D false;
 	}
=2D-- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) "ACPI: " fmt
=20
 #include <linux/async.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -2192,6 +2193,46 @@ static acpi_status acpi_bus_check_add_2(
 	return acpi_bus_check_add(handle, false, (struct acpi_device **)ret_p);
 }
=20
+static void acpi_video_bus_device_release(struct device *dev)
+{
+	struct auxiliary_device *aux_dev =3D to_auxiliary_dev(dev);
+
+	kfree(aux_dev);
+}
+
+static void acpi_create_video_bus_device(struct acpi_device *adev,
+					 struct acpi_device *parent)
+{
+	struct auxiliary_device *aux_dev;
+	static unsigned int aux_dev_id;
+
+	aux_dev =3D kzalloc_obj(*aux_dev);
+	if (!aux_dev)
+		return;
+
+	aux_dev->id =3D aux_dev_id++;
+	aux_dev->name =3D "video_bus";
+	aux_dev->dev.parent =3D acpi_get_first_physical_node(parent);
+	if (!aux_dev->dev.parent)
+		goto err;
+
+	aux_dev->dev.release =3D acpi_video_bus_device_release;
+
+	if (auxiliary_device_init(aux_dev))
+		goto err;
+
+	ACPI_COMPANION_SET(&aux_dev->dev, adev);
+	if (__auxiliary_device_add(aux_dev, "acpi")) {
+		auxiliary_device_uninit(aux_dev);
+		goto err;
+	}
+
+	return;
+
+err:
+	kfree(aux_dev);
+}
+
 struct acpi_scan_system_dev {
 	struct list_head node;
 	struct acpi_device *adev;
@@ -2229,6 +2270,12 @@ static void acpi_default_enumeration(str
 			sd->adev =3D device;
 			list_add_tail(&sd->node, &acpi_scan_system_dev_list);
 		}
+	} else if (device->pnp.type.backlight) {
+		struct acpi_device *parent;
+
+		parent =3D acpi_dev_parent(device);
+		if (parent)
+			acpi_create_video_bus_device(device, parent);
 	} else {
 		/* For a regular device object, create a platform device. */
 		acpi_create_platform_device(device, NULL);





