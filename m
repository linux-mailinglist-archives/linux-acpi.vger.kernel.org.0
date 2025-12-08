Return-Path: <linux-acpi+bounces-19489-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFF5CAD570
	for <lists+linux-acpi@lfdr.de>; Mon, 08 Dec 2025 14:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3952F3034EEB
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Dec 2025 13:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E0C2FA0DF;
	Mon,  8 Dec 2025 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="U2pGSVR9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20B57FBA2;
	Mon,  8 Dec 2025 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765202071; cv=none; b=XXEOQMDD/woLjz5AYX7yyP1qFaP6FzdFNdvbAhxSoyychzwzvC9KBPtGtWd4rtrJqlaK1gweZqVN3GrHnFKNle7RVoEj5znbQo74X+yWZ1nXb17z+GT0LSqz9dQYkDHs3ddLa3t8bLQNzsNiDZdD3DaddMhXsZ/n+s0yRVhbi0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765202071; c=relaxed/simple;
	bh=XtK02cbQGJzTmXjZJenafX/U340FWeJFTUEhhlzX5Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXqX9fuCT9MwQL9ztuuKyqUIPgSt3UX3O6mBi7QAbuJheujbGrmg4UHYJJQgKvnVjg8mfKRe/Zx2P/ThkfhYhKbjRm7B+6+3v/RScibaM5QrueSsWVyT0+Yw+qn6Ra+LSH6lZm3Ju4HilqZLbhgBsn7JlFrQ41zbaoSwK0KHgb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=U2pGSVR9; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=pyBHShYcd9rE8qx6LeUTgJCwaJuxWQkXiDuPREcistA=; t=1765202069;
	x=1765634069; b=U2pGSVR9vLC2zT4SiOzeo+Og4rOo/TcTH8VqpkkKqiVuFEnwGBCySovCE4Yop
	7AoKNfuBYDxRZiJxeVSg6M1JPDen2Xe6GTRU+VslbsVZp3a1LpsSyysk7t4hMSQOaT14KnUwPxlvN
	//tg98/PjEzGPSzJLCOuUk5MQCyiovHPSSbxrht/XnkSKKovKzSZN1n8y+ugsTtnHZnQEotQFcyWx
	eJdkjYVWZEQxv9CJxLN7XhZl1o97vD3UYUvq+f+6iWSecSnhUUW/QtS5nRxPTS8PfMLAVpaACxURU
	ESZ5PT7W7GWnAlVBDH6Vp2PFChiHXszjKeNsQqVGlzkXvUKfew==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vSbgz-004PPM-0G;
	Mon, 08 Dec 2025 14:54:21 +0100
Message-ID: <2c8d4baa-679f-4af7-a78d-41774410e9a6@leemhuis.info>
Date: Mon, 8 Dec 2025 14:54:20 +0100
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
 <08000f1a-2c1e-4a0d-a5b5-fc7dcea3d8a8@leemhuis.info>
 <CAMBhvbZHcOwd-i04TGMXdbvi1vmpnyPD1p7SgkUtjfFsc+9nWQ@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <CAMBhvbZHcOwd-i04TGMXdbvi1vmpnyPD1p7SgkUtjfFsc+9nWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1765202069;a3631cee;
X-HE-SMSGID: 1vSbgz-004PPM-0G

On 12/8/25 13:13, Vijay wrote:
> 
> Yes, the touchpad is not working in 6.18 also, getting the same errors
> as mentioned previously, 

That's really good to know, thx!

Thing is: I fear that nobody will look into this, unless you or somebody
else affected checks which change broke things. Benjamin mentioned three
you could try reverting in 6.17.y; alternatively, perform a bisection in
6.17.y. For details, see:
https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html

Ciao, Thorsten


> On Thu, 4 Dec 2025 at 20:40, Thorsten Leemhuis
> <regressions@leemhuis.info <mailto:regressions@leemhuis.info>> wrote:
> 
>     Lo!
> 
>     @AM Vijay: 6.17.y will be EOL in about ten days, so this is unlikely to
>     get fixed there. The big question is:
> 
>     Is 6.18 affected?
> 
>     If it is, we need your help identifying want went wrong; if not, then
>     it's likely not worth looking closer into this
> 
>     Ciao, Thorsten
> 
>     On 11/28/25 09:05, Benjamin Tissoires wrote:
>     > Hi,
>     >
>     > On Fri, Nov 28, 2025 at 7:40 AM Vijay <vijayg0127@gmail.com
>     <mailto:vijayg0127@gmail.com>> wrote:
>     >>
>     >> Hello,
>     >>
>     >> I would like to report a regression in the Linux kernel affecting
>     I2C-HID
>     >> touchpads that run through the Intel ISH + DesignWare I2C controller.
>     >>
>     >> Hardware:
>     >> - Laptop: Infinix Y4 Max
>     >> - CPU: Intel (13th gen core i5)
>     >> - Touchpad: SYNA3602:00 093A:35ED (I2C HID)
>     >> - Bus path: SYNA3602 → i2c_designware → Intel ISH → HID
>     >> - OS: Linux (Arch/CachyOS)
>     >> - Kernel config: Default distro config
>     >>
>     >> Regression summary:
>     >> - Touchpad works perfectly in Linux 6.17.6 and below versions
>     >> - Touchpad stops working in Linux 6.17.7 and all newer versions
>     (6.17.8, 6.17.9, etc.)
>     >> - Desktop environment does not matter (Hyprland/GNOME both fail)
>     >> - The failure happens before userspace loads
>     >> - Touchpad also works fine in Linux 6.12 LTS
>     >>
>     >> This is a kernel-level regression introduced between:
>     >>     Good: Linux 6.17.6
>     >>     Bad:  Linux 6.17.7
>     >>
>     >> **Dmesg logs from broken kernel (6.17.7 and newer):**
>     >>
>     >>     i2c-SYNA3602:00: can't add hid device: -110
>     >>     hid_sensor_hub: reading report descriptor failed
>     >>     intel-hid INTC1078:00: failed to enable HID power button
>     >
>     > Looks like i2c-hid can't even communicate with any I2C device, so this
>     > is slightly worrying.
>     >
>     >>
>     >> And the DesignWare I2C controller logs around the failure:
>     >>     i2c_designware 0000:00:15.0: controller timed out
>     >>     i2c_designware 0000:00:15.0: lost arbitration
>     >>     i2c_designware 0000:00:15.0: transfer aborted (status = -110)
>     >>
>     >> These errors appear only on 6.17.7+ and not on 6.17.6.
>     >>
>     >> On working versions (6.17.6 and 6.12 LTS), the touchpad
>     initializes normally:
>     >>
>     >>     input: SYNA3602:00 093A:35ED Touchpad as /devices/.../input/
>     inputX
>     >>     hid-multitouch: I2C HID v1.00 device initialized
>     >>     i2c_designware 0000:00:15.0: controller operating normally
>     >>
>     >> This narrow regression window should make it possible to identify
>     the offending
>     >> change in either:
>     >> - HID core
>     >> - I2C-HID
>     >> - Intel ISH HID
>     >> - DesignWare I2C controller
>     >> - ACPI timing changes
>     >>
>     >> I can provide:
>     >> - Full dmesg (working and broken)
>     >> - acpidump
>     >
>     > Are you running on a full vanilla kernel?
>     >
>     > The changelog between 6.17.6 and 6.17.7 is rather small, so it should
>     > be easy enough to bisect and get the offending commit.
>     >
>     > I have my suspicions on:
>     > f1971d5ba2ef ("genirq/manage: Add buslock back in to enable_irq()")
>     > b990b4c6ea6b ("genirq/manage: Add buslock back in to
>     __disable_irq_nosync()")
>     > 3c97437239df ("genirq/chip: Add buslock back in to irq_set_handler()")
>     >
>     > Because anything else is unrelated to any component involved in
>     i2c-hid.
>     > (But that's also assuming you are running vanilla kernels without any
>     > extra patches.)
>     >
>     > OTOH, I've booted a 6.17.8 and 6.17.7 shipped by Fedora and I don't
>     > see any issues related to i2c-hid, so those 3 commits might not be the
>     > culprits.
>     >
>     >
>     >>
>     >> Please let me know what additional data is needed.
>     >
>     > Can you do a bisect between v6.17.7 and v6.17.6?
>     >
>     > Cheers,
>     > Benjamin
>     >
>     >>
>     >> Thank you,
>     >> Vijay.
>     >
>     >
>     >
> 


