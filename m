Return-Path: <linux-acpi+bounces-10314-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD809FD501
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Dec 2024 14:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E639161975
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Dec 2024 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745951F37B3;
	Fri, 27 Dec 2024 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=i2labs.ca header.i=nolan@i2labs.ca header.b="dSKnLFpZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E202118870C
	for <linux-acpi@vger.kernel.org>; Fri, 27 Dec 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735306567; cv=pass; b=HovBCXla6BvgQ56Rjs90omEPIzxKPz0B8iTrWQPqib4n5gD+qJsoaYJr1eQYar+otnYScabLb7r3F7WoMkwTPsbieh5fqmlD3qrb22JxUvXsFDVRos5iHDI5UCBX6bmJELL26eMlaPVPUFzkMfO1JuD7+fWelMEmd/acsprBk3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735306567; c=relaxed/simple;
	bh=2siXIr6vXKYuOu52MjvxDfBUanEbgR6/Ulq5oEDYWOQ=;
	h=Message-ID:Date:MIME-Version:From:Cc:Subject:To:Content-Type; b=ucrOVDKErTVYZglaf+hxs/4G0JujEjB7apupfp0T6Vxv0FD7/jyPXBHoH/slTNMZURwa88So1is677EDOf5gRJz4+OPM+PNz4aQEhfGyfI+Lw87fE3TX+IPsApvBnh6SrZPJeuNHG7lxc0+/neg0JHjhO8B4arEspe+fIyXdx0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=i2labs.ca; spf=pass smtp.mailfrom=i2labs.ca; dkim=pass (1024-bit key) header.d=i2labs.ca header.i=nolan@i2labs.ca header.b=dSKnLFpZ; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=i2labs.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=i2labs.ca
ARC-Seal: i=1; a=rsa-sha256; t=1735306562; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M+ByDeY9FaF8/xqlfRV9mZqm8Dw+Kz2EL/HTfIjpkSkQ0QNp+oxlrDjDV2Cnwdasu+haCAdygxbQfca8Jt2JXDFzp/mawlUsjvw3gRLwb9m4ZiaWC8Vsri41faqpVUpdef7zNtK9ZQaWmBlTAWnFEl2s0iU/uxNGgN1SFAGTX88=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1735306562; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5JnQD0U793rRicOqL4W0vr3rzt3gaJfgJbXB/eH9MkM=; 
	b=Qf650dYc4ybTi3glu9T+3m8lGb4uzXgKfyWJwN9UyjuRtNZeQkAEAMKCeYiqSLltKTFOmaUnmz2FR0k+dhdu51YRZMRRhPy/MN7r7bTt1hs2CvNmW3D5tkDaQTzTwrWcAKyRzRo46Fe1+EwK9CvAOsrMgBv/++Syu3cDrs6YB5Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=i2labs.ca;
	spf=pass  smtp.mailfrom=nolan@i2labs.ca;
	dmarc=pass header.from=<nolan@i2labs.ca>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1735306562;
	s=zoho; d=i2labs.ca; i=nolan@i2labs.ca;
	h=Message-ID:Date:Date:MIME-Version:From:From:Cc:Cc:Subject:Subject:To:To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=5JnQD0U793rRicOqL4W0vr3rzt3gaJfgJbXB/eH9MkM=;
	b=dSKnLFpZfNax3iXCKs1XhneeO2dQi8kF2rNYmf2DlukNKX2XHaOWLcx76kFURXNe
	4P2QOfFP303r+zHO6pJkpngqtDcMaFoo+ykgX/fPV6RHGx2vS6eiODWWTbV1fmIpqsm
	jeIaoHOA66ed10YQv+fU4HVkVHKYH1D5Uh45DsDo=
Received: by mx.zohomail.com with SMTPS id 1735306559847225.49442676059277;
	Fri, 27 Dec 2024 05:35:59 -0800 (PST)
Message-ID: <43d1d35b-d875-4e05-b0ff-a9bfde5ef34a@i2labs.ca>
Date: Fri, 27 Dec 2024 20:35:34 +0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nolan Woods <nolan@i2labs.ca>
Cc: Nolan Woods <nolan@i2labs.ca>
Subject: [PATCH] acpi: Emit udev 'update' event after battery add hooks
Content-Language: en-US
To: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

A 'add' uevent is emitted after adding respective /sys/class/
power_supply/BAT* devices via battery.c:sysfs_add_battery(...) ->
power_supply_core.c:power_supply_register(...) ->
core.c:device_add(...). Additional drivers (asus-wmi for example) can
register hooks that are called after the sysfs attributes are added by
power_supply_register. These hooks are normally used to add additional
attributes to sysfs. These additional attributes are not available at
the time that the 'add' uevent is emitted. udev rules are not able to
interact with them as the hooks are called after the 'add' uevent is
resolved. An additional 'update' uevent is needed to allow udev rules to
trigger once all hooks have been processed.

Signed-off-by: Nolan Woods <nolan@i2labs.ca>
---
  drivers/acpi/battery.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 3d5342f8d7b3..abe861946eb6 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -899,6 +899,7 @@ static int sysfs_add_battery(struct acpi_battery 
*battery)
  		return result;
  	}
  	battery_hook_add_battery(battery);
+	kobject_uevent(battery->bat->dev->kobj, KOBJ_CHANGE);
  	return 0;
  }
  --


This is my first contribution to this repo. Please let me know if there 
are any formatting issues of this submission.

I am looking for feedback on if kobject_uevent() should be called as 
described in this patch or if it should be at the end of the definition 
of battery_hook_add_battery.

Also, does it make sense that the "update" (KOBJ_CHANGE) event is sent 
after the battery hooks make arbitrary changes? or is "update" strictly 
for hardware/device initiated changes and I need to find a different 
mechanism to trigger user space logic after the battery hooks?

An example udev rule that only works with this patch:
ACTION=="update", KERNEL=="BAT0", RUN+="/bin/chmod 666 
/sys/class/power_supply/BAT0/charge_control_end_threshold"

The following does not work as 
/sys/class/power_supply/BAT0/charge_control_end_threshold does not exist 
when the event is resolved:
ACTION=="add", KERNEL=="BAT0", RUN+="/bin/chmod 666 
/sys/class/power_supply/BAT0/charge_control_end_threshold"

charge_control_end_threshold is created at asus-wmi.c:1446.

Thank you for your time.

