Return-Path: <linux-acpi+bounces-20719-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMUqM0BVemnk5AEAu9opvQ
	(envelope-from <linux-acpi+bounces-20719-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 19:28:16 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE06A7C03
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 19:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D59F300C56E
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 18:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BA736A03F;
	Wed, 28 Jan 2026 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs+Dw+EC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3C23D7CF
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769624296; cv=none; b=jZSSlH4yY5AN4FhWB8fApWxH9/Dd3F7gVFAMRBl3TcLVXIZjNH2X/lKgAO1idfF1RCwr5g1eb7ioBaCXlugL7gBhXKHK3nX/mp3QWgVlchKW0aO2VDKnSFvddRT5sRY7qId7JRSS+neunChg6C0mCmLhBsZ4t7K3lgjcLXEoYGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769624296; c=relaxed/simple;
	bh=z6HqVvjrRZwDtLZ0aZQZ4E0/om9TTG2acbvgmUcLPtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HArYY1315SrdtfyGfywRh1VRFL6xavrdwEUBshUt4p8KCj981sTZNGsgXwuqH7qb12mLchSnaDo+0wGHwQTqWXQGqRp+U2vL1V2qX8zk70oC70vWrPWq282GRZTPiqkWjv9hSAwIAJtf28Gh10+kfYlHanhoKLtuFwkB/fDeR5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gs+Dw+EC; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b70abe3417so421161eec.0
        for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 10:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769624294; x=1770229094; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0qJ3Pv+XrYbJcjXa5Kbl78tEiMouGJOHkvxNsGhCms=;
        b=Gs+Dw+EClCzKnblpXgj2phdTokE88BEBRufk5tqnugr0SCjukOBk2/hi/IUdNjP4aN
         8FEorXGUN0qYTbF8piiwhjiGpTY7xs5LwHBQHwLUjl9KhvTDWBr4f9U8lFGEsr7ARrNk
         i7rgytjwiOU+JI1JqqxJ1H54XIWMtF7w7+k7d2kmuJLqjmiMy9vQnUm55ozmrUe+n5/+
         3XlUi8GRdYfOhnmXTao0NtLwPKCC3Tl+8qwOEb1Nq4Mcm5Lyn6jYxDMLtF4FL+C3Mm6l
         3r0wynJShIoTzxNgHNFYXwRFssDa49FgvfDCGgz9mFVQmfKOGSK9oU/XuOKvpIAO3Jml
         7/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769624294; x=1770229094;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0qJ3Pv+XrYbJcjXa5Kbl78tEiMouGJOHkvxNsGhCms=;
        b=b58A3X49fpHIap0EzDIMjT6Aj+RvKemcmh2HfQw7JREQGwqcO0Qqfe9pnw44V266Nn
         Ds8xsnOav+/GVD96PAGHX3MYK05L60ocJIl8/InXskxUiL+iL2HU0CREgkRqXQZcHwTC
         pwufWIZ+wofsHrdwnfugBSl6zdnqIrTeOUq3a4B0ERkuDnZMFyV5P9Ua3K4A95d5QKKJ
         R7PPpkv71UCpXqCPPfEuFKFVxuLDDIxbwpm1a0rD5GY2xQcWcgzF0VEMMN1SfPvUxrMe
         ODE6XUZQhI7cla3xNvZn6x+3um53GXD1GIy18opqrZFTL5m76GJWviKFvn+2YvXIvrJn
         qChQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjvaEzgRNcjb2eyNmhkDoCrbSLcvGCqgqW941AdgQ04XP1uK8BI1aoTZp4In0U7IASXbvAYd2M5rzv@vger.kernel.org
X-Gm-Message-State: AOJu0YxTAEtO+jtYExBDnXNSZ7rfGhjAd2iNdPQeTxkU9RozGF4G7WVZ
	0z1D894re8A4FiXR2xNd5LBONt5T+Op5YrVM/WnP5tPRNOSfnXX51xk1
X-Gm-Gg: AZuq6aIja9DNZA7xDXS9P1XsiziEdPp8siOQTvVE3tINfv5f2QYVtSWlzvJG3mBMPFU
	n1qu2RWFpXobkc1DqBz+9Wl6nPA9/9MMwIYm0vRlMrDeCynGPq8Us4Fz1YEBN5xlhfi90faZi2y
	q56WTAzWxQFqNyAKvPvIVif4c0lf+m2fqX36fP6OFjW/ZCggQtaHmb8StHy9EJRo+eO7Kop86NN
	sOaV6uaKyjzL7Zt30apK+70wpFEuVv0zEhr4sVWSAs50/2Ji1Fq2krXI6NK9YoBTyxGTZmgBUnl
	Z16QprczMW2nQy/zLZR4IbeJnyR04VtfXzMg4LUJxVb0kxetrOC2TSinw2Z78CnxxnCiwuYFr98
	jkS8m3D+7IVVJLA/wJkXLZnoSiRpGLA9Wti+V634fV3rAXlVjYvJD7gIGKFPShv6AADXcYJW4+v
	rIThGhzlJ6ElXrn2xYWGfvfC2i
X-Received: by 2002:a05:7301:4196:b0:2b7:24fc:f638 with SMTP id 5a478bee46e88-2b78d54358amr3228247eec.0.1769624294049;
        Wed, 28 Jan 2026 10:18:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abedcasm3607087eec.21.2026.01.28.10.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 10:18:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 28 Jan 2026 10:18:12 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Igor Raits <igor@gooddata.com>,
	Daniel Secik <daniel.secik@gooddata.com>,
	Zdenek Pesek <zdenek.pesek@gooddata.com>,
	Jiri Jurica <jiri.jurica@gooddata.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: acpi_power_meter: power*_average sysfs read hangs, mutex
 deadlock in hwmon_attr_show since v6.18.y
Message-ID: <1d969bd7-4969-455d-9600-e4be14a78217@roeck-us.net>
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAJZ5v0jSbGtRYkjqeuYaT3LXbeZ-xk_Gc0dbCpTZPc6nBD8eCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jSbGtRYkjqeuYaT3LXbeZ-xk_Gc0dbCpTZPc6nBD8eCQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20719-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DE06A7C03
X-Rspamd-Action: no action

Hi all,

On Thu, Jan 22, 2026 at 07:55:35PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 22, 2026 at 7:21 PM Jaroslav Pulchart
> <jaroslav.pulchart@gooddata.com> wrote:
> >
> > Hello,
> >
> > after upgrading from kernel 6.17.y to 6.18.y we started to observe a regression
> > in the ACPI power meter hwmon interface. Reading power*_average sysfs
> > attributes blocks indefinitely and causes tasks to enter uninterruptible
> > sleep (D state).
> 
> The most recent change in the acpi_power_meter driver was made in
> 6.15, so this is not a regression in that driver.
> 
> Also, nothing suspicious is done in power1_average_min_show() and
> power1_average_min_store() AFAICS.
> 

I decided to ask AI (Gemini 3, more specifically) for an analysis of the
problem, using Chris Mason's prompts for guidance. Result is below.

The suggested fix may be a feasible workaround. Let me know what you think.

Thanks,
Guenter

---
Summary of crash or warning
Deadlock in acpi_power_meter driver between sysfs read and ACPI notify.

Kernel version if available
6.18.6-1.gdc.el9.x86_64

Cleaned up copy of oops or stack trace
[  740.721209] Call Trace:
[  741.467334]  power_meter_read+0x1ea/0x2c0 [acpi_power_meter]
[  741.475320]  hwmon_attr_show+0x5e/0x130
[  741.481343]  dev_attr_show+0x19/0x60
[  741.487325]  sysfs_kf_seq_show+0xbf/0x140
[  741.494315]  seq_read_iter+0x112/0x510
[  741.503544]  vfs_read+0x215/0x340

[  740.286380] INFO: task alloy:5901 blocked for more than 122 seconds.
[  740.326290] Call Trace:
[  740.336311]  __schedule+0x2b5/0x690
[  740.341312]  schedule+0x23/0x80
[  740.354335]  __mutex_lock.constprop.0+0x3c9/0xa00
[  740.360318]  hwmon_attr_show+0x36/0x130

Explanation of the problem
The acpi_power_meter driver exhibits a deadlock when acpi_power_meter_notify
is called with METER_NOTIFY_CONFIG while a userspace process is concurrently
reading a sysfs attribute (e.g., power1_average).

The deadlock occurs because acpi_power_meter_notify acquires resource->lock
and then calls hwmon_device_unregister. The hwmon_device_unregister function
(via device_unregister and kernfs_remove) waits for all active sysfs callbacks
to complete. However, the active sysfs callback (power_meter_read) tries to
acquire resource->lock which is already held by acpi_power_meter_notify.

Sequence of events:
1. Userspace reads power1_average.
2. hwmon_attr_show is called. It calls power_meter_read.
3. power_meter_read attempts to acquire resource->lock.
4. Concurrently, ACPI triggers acpi_power_meter_notify with METER_NOTIFY_CONFIG.
5. acpi_power_meter_notify acquires resource->lock.
6. acpi_power_meter_notify calls hwmon_device_unregister.
7. hwmon_device_unregister waits for the active hwmon_attr_show (and thus
   power_meter_read) to return.
8. power_meter_read is blocked waiting for resource->lock.
9. acpi_power_meter_notify is blocked waiting for power_meter_read to finish.

This results in a deadlock and hung tasks. Other tasks trying to read sysfs
attributes also hang waiting for the hwmon core lock (hwdev->lock) which is
held by the blocked reader.

Functions, snippets and call traces of code related to the problem

drivers/hwmon/acpi_power_meter.c:

static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
{
        struct acpi_power_meter_resource *resource;
        int res;

        if (!device || !acpi_driver_data(device))
                return;

        resource = acpi_driver_data(device);

        switch (event) {
        case METER_NOTIFY_CONFIG:
                mutex_lock(&resource->lock);
                free_capabilities(resource);
                remove_domain_devices(resource);
                hwmon_device_unregister(resource->hwmon_dev); /* DEADLOCK HERE */
                res = read_capabilities(resource);
                /* ... */
                mutex_unlock(&resource->lock);
                break;
        /* ... */
}

static int power_meter_read(struct device *dev, enum hwmon_sensor_types type,
                            u32 attr, int channel, long *val)
{
        struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
        int ret = 0;

        if (type != hwmon_power)
                return -EINVAL;

        guard(mutex)(&res->lock); /* BLOCKED HERE */

        switch (attr) {
        case hwmon_power_average:
                ret = update_meter(res);
                /* ... */
        }
        return 0;
}

Suggested Fix
Move hwmon_device_unregister out of the critical section protected by
resource->lock. It should be called before acquiring the lock to modify
the resource structure.

drivers/hwmon/acpi_power_meter.c:

        case METER_NOTIFY_CONFIG:
-               mutex_lock(&resource->lock);
-               free_capabilities(resource);
-               remove_domain_devices(resource);
-               hwmon_device_unregister(resource->hwmon_dev);
+               if (resource->hwmon_dev) {
+                       hwmon_device_unregister(resource->hwmon_dev);
+                       resource->hwmon_dev = NULL;
+               }
+
+               mutex_lock(&resource->lock);
+               free_capabilities(resource);
+               remove_domain_devices(resource);
                res = read_capabilities(resource);

