Return-Path: <linux-acpi+bounces-19428-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E638BCA4322
	for <lists+linux-acpi@lfdr.de>; Thu, 04 Dec 2025 16:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C8A63001DD2
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Dec 2025 15:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F4B2DBF76;
	Thu,  4 Dec 2025 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Qaw0OJQ5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9162DAFDE;
	Thu,  4 Dec 2025 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764861046; cv=none; b=EUoEy67XboAOVP3Efp2ZVeVCZ+iK45+Ij6Yu7aSshEMywF6RLkA00ACj+sG6fYvoPEBT/PB8r0O27mRyFxVqbZ4YVzi+KTwShwhUjX2KXiklO5X0JAkSBzrHJZotFCNRHtRZFBtdv23EXrjYR/QNg47hanYla95IaBFjXVK3joA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764861046; c=relaxed/simple;
	bh=bfZFmNe7jatOQTK9tozxaSEopVXRcYgccuFzKdZNPdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEvhgIF92iF4inzSN5kAOEk+RLY/2LPUtCFPMaBcn9vfx2SrNxUG1Q1rEPXokboD+ZIeA2CEB6uA1+aRKEasrQzVSzr47TH/aSvz+4lP6j0tBun0y1P2FCYotpgDlIzxJPB3imy7sPYl0/zhUkAfwOAK390AUz8ss62FsPPtpGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Qaw0OJQ5; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=8VtqlbU7Up61NyYtebV4S/F1DYWfcykVq5pmrMT+3rI=; t=1764861044;
	x=1765293044; b=Qaw0OJQ53n19YCCLzUeOLd2Par3Uxc/N4WbXbm7kReG7b5EBW8AYo6An5ZqjJ
	KoyRVBqYeiAUWizxB/Qfl4KUfQWlWyYz58MXsWv5GOE1cmyLcKvPVtszC8WZ7soVbYMbywKooKXzA
	5WlfvXHIUUBv9WZHG0quUD+1/TdmQPXJxBBDIieaW1XCq83NwBIt8IaYNxln9/wsliuuOtfR0uzLB
	aenQFFzqN2LdPaVGiWXArC7AnyPqKk1lmzN9D+6Km6g1ZelYuzy9XCa2yyfMjYhb+UmHBFVWAgEmi
	ayzpu2mkNKTUwommIsF5+T2rAzxOfxKsF8UwbsyPtHYn1jeDLg==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vRAyg-009Jto-0T;
	Thu, 04 Dec 2025 16:10:42 +0100
Message-ID: <08000f1a-2c1e-4a0d-a5b5-fc7dcea3d8a8@leemhuis.info>
Date: Thu, 4 Dec 2025 16:10:41 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: SYNA3602 I2C touchpad broken in Linux 6.17.7 (works
 in 6.17.6 and previous versions)
To: Vijay <vijayg0127@gmail.com>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, jikos@kernel.org
References: <CAMBhvbYA=onQkkcgkODaTj=+tkybwo28Cdi6P3vodGpVZi8OVA@mail.gmail.com>
 <CAO-hwJJRisVpZWeSA+3_fLaa8_52f7ypUocDcD+PojuF3KjHYw@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <CAO-hwJJRisVpZWeSA+3_fLaa8_52f7ypUocDcD+PojuF3KjHYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1764861044;d5267d98;
X-HE-SMSGID: 1vRAyg-009Jto-0T

Lo!

@AM Vijay: 6.17.y will be EOL in about ten days, so this is unlikely to
get fixed there. The big question is:

Is 6.18 affected?

If it is, we need your help identifying want went wrong; if not, then
it's likely not worth looking closer into this

Ciao, Thorsten

On 11/28/25 09:05, Benjamin Tissoires wrote:
> Hi,
> 
> On Fri, Nov 28, 2025 at 7:40 AM Vijay <vijayg0127@gmail.com> wrote:
>>
>> Hello,
>>
>> I would like to report a regression in the Linux kernel affecting I2C-HID
>> touchpads that run through the Intel ISH + DesignWare I2C controller.
>>
>> Hardware:
>> - Laptop: Infinix Y4 Max
>> - CPU: Intel (13th gen core i5)
>> - Touchpad: SYNA3602:00 093A:35ED (I2C HID)
>> - Bus path: SYNA3602 → i2c_designware → Intel ISH → HID
>> - OS: Linux (Arch/CachyOS)
>> - Kernel config: Default distro config
>>
>> Regression summary:
>> - Touchpad works perfectly in Linux 6.17.6 and below versions
>> - Touchpad stops working in Linux 6.17.7 and all newer versions (6.17.8, 6.17.9, etc.)
>> - Desktop environment does not matter (Hyprland/GNOME both fail)
>> - The failure happens before userspace loads
>> - Touchpad also works fine in Linux 6.12 LTS
>>
>> This is a kernel-level regression introduced between:
>>     Good: Linux 6.17.6
>>     Bad:  Linux 6.17.7
>>
>> **Dmesg logs from broken kernel (6.17.7 and newer):**
>>
>>     i2c-SYNA3602:00: can't add hid device: -110
>>     hid_sensor_hub: reading report descriptor failed
>>     intel-hid INTC1078:00: failed to enable HID power button
> 
> Looks like i2c-hid can't even communicate with any I2C device, so this
> is slightly worrying.
> 
>>
>> And the DesignWare I2C controller logs around the failure:
>>     i2c_designware 0000:00:15.0: controller timed out
>>     i2c_designware 0000:00:15.0: lost arbitration
>>     i2c_designware 0000:00:15.0: transfer aborted (status = -110)
>>
>> These errors appear only on 6.17.7+ and not on 6.17.6.
>>
>> On working versions (6.17.6 and 6.12 LTS), the touchpad initializes normally:
>>
>>     input: SYNA3602:00 093A:35ED Touchpad as /devices/.../input/inputX
>>     hid-multitouch: I2C HID v1.00 device initialized
>>     i2c_designware 0000:00:15.0: controller operating normally
>>
>> This narrow regression window should make it possible to identify the offending
>> change in either:
>> - HID core
>> - I2C-HID
>> - Intel ISH HID
>> - DesignWare I2C controller
>> - ACPI timing changes
>>
>> I can provide:
>> - Full dmesg (working and broken)
>> - acpidump
> 
> Are you running on a full vanilla kernel?
> 
> The changelog between 6.17.6 and 6.17.7 is rather small, so it should
> be easy enough to bisect and get the offending commit.
> 
> I have my suspicions on:
> f1971d5ba2ef ("genirq/manage: Add buslock back in to enable_irq()")
> b990b4c6ea6b ("genirq/manage: Add buslock back in to __disable_irq_nosync()")
> 3c97437239df ("genirq/chip: Add buslock back in to irq_set_handler()")
> 
> Because anything else is unrelated to any component involved in i2c-hid.
> (But that's also assuming you are running vanilla kernels without any
> extra patches.)
> 
> OTOH, I've booted a 6.17.8 and 6.17.7 shipped by Fedora and I don't
> see any issues related to i2c-hid, so those 3 commits might not be the
> culprits.
> 
> 
>>
>> Please let me know what additional data is needed.
> 
> Can you do a bisect between v6.17.7 and v6.17.6?
> 
> Cheers,
> Benjamin
> 
>>
>> Thank you,
>> Vijay.
> 
> 
> 


