Return-Path: <linux-acpi+bounces-20477-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIw4OPfyb2m+UQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20477-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 22:26:15 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C7D4C390
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 22:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DD4866DDC0
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 19:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199AA47A0DF;
	Tue, 20 Jan 2026 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFH9wQHM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD644D028;
	Tue, 20 Jan 2026 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937883; cv=none; b=AZ/GhZCBFq383ujrWtpWC0R/fhjPxdL5ZxYCOUQCL9tvQMjesNNstw5VtXRk8H9wz5zbBNVLnNQGklPhf0kxpGl4H61iN24AOky7z+iKYjUsZB6R47X+7Sl67LHaLhyTAQ8/skFMF1Mht+QJZwQ/mMWR1HoZm8e7RIUvT77/W8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937883; c=relaxed/simple;
	bh=aLYewYaidV95JSBfkMgzIpwgMWf1mMuoxBwdhsvxb2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtlzV14XraDQLZxuNsVlbaUySfrfFzM0MzzuleXVE883J9MpEnLqLmIaqmrdSTjJncMxVJHT+z8OKIcIkfTpN9p4Hghym5sK7CzxTSovi1EUNCHWFuUqxfRCrrvrJ6UI2pmScn/TQU8eOJEr/MjT0QUP2mqf+wVCateJRrugF+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFH9wQHM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768937882; x=1800473882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aLYewYaidV95JSBfkMgzIpwgMWf1mMuoxBwdhsvxb2g=;
  b=FFH9wQHM3drbqZgyx0/OzJ7NZe+BTYB84hJF0Z6afu7wxzhhKTMeUfZE
   9aAzJS3GhPfj++fUuDL3CuIGLJYkoe2jETBaJQIbfkUgUQCzepSSpgjwo
   wRvRQN2u0GKetrTqpl7A0n0rzV0+zDDq+M23W5j/r62fnRH4HRIKKHpL2
   i6R5JIXzr4jRpk6QcpWW6oMYLUN0TQ5u7lTgM2EAySvKYAlcUo0631z+T
   MAQ1M8x/mT0NARzCp23Y95/TxiImeECiClw3OQRnOVSlYF5Kf4mHzz0PO
   QvjPQvciWVIpKZkhrFKo/3NaKAFVsk02dIIxtA3JSOhhGf2oIZr/yUNGi
   Q==;
X-CSE-ConnectionGUID: /ZFfWdayThekinlsqL7bug==
X-CSE-MsgGUID: VUVwr74HSrG7ZTVOGLvIqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70323654"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="70323654"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:38:00 -0800
X-CSE-ConnectionGUID: cQamuSVDSKmyrHbjuRvDPg==
X-CSE-MsgGUID: M3Zt97TzQMK9R7gTkA3DeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="210666001"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 20 Jan 2026 11:37:57 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id DFA4595; Tue, 20 Jan 2026 20:37:55 +0100 (CET)
Date: Tue, 20 Jan 2026 20:37:55 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Vijay <vijayg0127@gmail.com>, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	jikos@kernel.org
Subject: Re: Regression: SYNA3602 I2C touchpad broken in Linux 6.17.7 (works
 in 6.17.6 and previous versions)
Message-ID: <aW_Zk7v63HPJl01C@black.igk.intel.com>
References: <CAMBhvbYA=onQkkcgkODaTj=+tkybwo28Cdi6P3vodGpVZi8OVA@mail.gmail.com>
 <CAO-hwJJRisVpZWeSA+3_fLaa8_52f7ypUocDcD+PojuF3KjHYw@mail.gmail.com>
 <08000f1a-2c1e-4a0d-a5b5-fc7dcea3d8a8@leemhuis.info>
 <CAMBhvbZHcOwd-i04TGMXdbvi1vmpnyPD1p7SgkUtjfFsc+9nWQ@mail.gmail.com>
 <2c8d4baa-679f-4af7-a78d-41774410e9a6@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c8d4baa-679f-4af7-a78d-41774410e9a6@leemhuis.info>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org,redhat.com,kernel.org];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-20477-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-acpi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[black.igk.intel.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:dkim,leemhuis.info:email]
X-Rspamd-Queue-Id: 70C7D4C390
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Dec 08, 2025 at 02:54:20PM +0100, Thorsten Leemhuis wrote:
> On 12/8/25 13:13, Vijay wrote:
> > 
> > Yes, the touchpad is not working in 6.18 also, getting the same errors
> > as mentioned previously, 
> 
> That's really good to know, thx!
> 
> Thing is: I fear that nobody will look into this, unless you or somebody
> else affected checks which change broke things. Benjamin mentioned three
> you could try reverting in 6.17.y; alternatively, perform a bisection in
> 6.17.y. For details, see:
> https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html

Might be related:
https://bugzilla.kernel.org/show_bug.cgi?id=219799

> > On Thu, 4 Dec 2025 at 20:40, Thorsten Leemhuis
> > <regressions@leemhuis.info <mailto:regressions@leemhuis.info>> wrote:
> > 
> >     Lo!
> > 
> >     @AM Vijay: 6.17.y will be EOL in about ten days, so this is unlikely to
> >     get fixed there. The big question is:
> > 
> >     Is 6.18 affected?
> > 
> >     If it is, we need your help identifying want went wrong; if not, then
> >     it's likely not worth looking closer into this
> > 
> >     Ciao, Thorsten
> > 
> >     On 11/28/25 09:05, Benjamin Tissoires wrote:
> >     > Hi,
> >     >
> >     > On Fri, Nov 28, 2025 at 7:40 AM Vijay <vijayg0127@gmail.com
> >     <mailto:vijayg0127@gmail.com>> wrote:
> >     >>
> >     >> Hello,
> >     >>
> >     >> I would like to report a regression in the Linux kernel affecting
> >     I2C-HID
> >     >> touchpads that run through the Intel ISH + DesignWare I2C controller.
> >     >>
> >     >> Hardware:
> >     >> - Laptop: Infinix Y4 Max
> >     >> - CPU: Intel (13th gen core i5)
> >     >> - Touchpad: SYNA3602:00 093A:35ED (I2C HID)
> >     >> - Bus path: SYNA3602 → i2c_designware → Intel ISH → HID
> >     >> - OS: Linux (Arch/CachyOS)
> >     >> - Kernel config: Default distro config
> >     >>
> >     >> Regression summary:
> >     >> - Touchpad works perfectly in Linux 6.17.6 and below versions
> >     >> - Touchpad stops working in Linux 6.17.7 and all newer versions
> >     (6.17.8, 6.17.9, etc.)
> >     >> - Desktop environment does not matter (Hyprland/GNOME both fail)
> >     >> - The failure happens before userspace loads
> >     >> - Touchpad also works fine in Linux 6.12 LTS
> >     >>
> >     >> This is a kernel-level regression introduced between:
> >     >>     Good: Linux 6.17.6
> >     >>     Bad:  Linux 6.17.7
> >     >>
> >     >> **Dmesg logs from broken kernel (6.17.7 and newer):**
> >     >>
> >     >>     i2c-SYNA3602:00: can't add hid device: -110
> >     >>     hid_sensor_hub: reading report descriptor failed
> >     >>     intel-hid INTC1078:00: failed to enable HID power button
> >     >
> >     > Looks like i2c-hid can't even communicate with any I2C device, so this
> >     > is slightly worrying.
> >     >
> >     >>
> >     >> And the DesignWare I2C controller logs around the failure:
> >     >>     i2c_designware 0000:00:15.0: controller timed out
> >     >>     i2c_designware 0000:00:15.0: lost arbitration
> >     >>     i2c_designware 0000:00:15.0: transfer aborted (status = -110)
> >     >>
> >     >> These errors appear only on 6.17.7+ and not on 6.17.6.
> >     >>
> >     >> On working versions (6.17.6 and 6.12 LTS), the touchpad
> >     initializes normally:
> >     >>
> >     >>     input: SYNA3602:00 093A:35ED Touchpad as /devices/.../input/
> >     inputX
> >     >>     hid-multitouch: I2C HID v1.00 device initialized
> >     >>     i2c_designware 0000:00:15.0: controller operating normally
> >     >>
> >     >> This narrow regression window should make it possible to identify
> >     the offending
> >     >> change in either:
> >     >> - HID core
> >     >> - I2C-HID
> >     >> - Intel ISH HID
> >     >> - DesignWare I2C controller
> >     >> - ACPI timing changes
> >     >>
> >     >> I can provide:
> >     >> - Full dmesg (working and broken)
> >     >> - acpidump
> >     >
> >     > Are you running on a full vanilla kernel?
> >     >
> >     > The changelog between 6.17.6 and 6.17.7 is rather small, so it should
> >     > be easy enough to bisect and get the offending commit.
> >     >
> >     > I have my suspicions on:
> >     > f1971d5ba2ef ("genirq/manage: Add buslock back in to enable_irq()")
> >     > b990b4c6ea6b ("genirq/manage: Add buslock back in to
> >     __disable_irq_nosync()")
> >     > 3c97437239df ("genirq/chip: Add buslock back in to irq_set_handler()")
> >     >
> >     > Because anything else is unrelated to any component involved in
> >     i2c-hid.
> >     > (But that's also assuming you are running vanilla kernels without any
> >     > extra patches.)
> >     >
> >     > OTOH, I've booted a 6.17.8 and 6.17.7 shipped by Fedora and I don't
> >     > see any issues related to i2c-hid, so those 3 commits might not be the
> >     > culprits.

> >     >> Please let me know what additional data is needed.
> >     >
> >     > Can you do a bisect between v6.17.7 and v6.17.6?

-- 
With Best Regards,
Andy Shevchenko



