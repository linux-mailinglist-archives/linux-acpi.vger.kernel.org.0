Return-Path: <linux-acpi+bounces-2275-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 255DF80CB23
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 14:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC96B20E8E
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 13:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB2E3F8D4;
	Mon, 11 Dec 2023 13:37:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0854CF;
	Mon, 11 Dec 2023 05:37:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3116FEC;
	Mon, 11 Dec 2023 05:38:00 -0800 (PST)
Received: from [10.57.84.143] (unknown [10.57.84.143])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21ECB3F762;
	Mon, 11 Dec 2023 05:37:12 -0800 (PST)
Message-ID: <a317fd5b-85df-409f-96e2-8123eea6ca73@arm.com>
Date: Mon, 11 Dec 2023 13:38:16 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] thermal: core: Remove thermal zones during
 unregistration
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <1880915.tdWV9SEqCh@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1880915.tdWV9SEqCh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 12/8/23 19:11, Rafael J. Wysocki wrote:
> Hi All,
> 
> This patch series adds a mechanism to guarantee that
> thermal_zone_device_unregister() will not return until all of the active
> references to the thermal zone device object in question have been dropped
> and it has been deleted (patch [1/3]).
> 
> This supersedes the approach used so far in which all thermal zone sysfs
> attribute callbacks check if the zone device is still registered under the
> zone lock, so as to return early if that is not the case, as it means that
> device_del() has been called for the thermal zone in question (and returned).
> It is not necessary to do that any more after patch [1/3], so patch [2/3]
> removes those checks from the code and drops zone locking that is not
> necessary any more either.
> 
> Patch [3/3] uses the observation that the thermal subsystem does not need to
> check if a thermal zone device is registered at all, because it can use its
> own data to determine whether or not the thermal zone is going away and so
> it may not be worth updating it, for example.
> 
> Please refer to the patch changelogs for details.
> 
> The series depends on new thermal material in linux-next, but it should not
> substantially depend on any changes that have not made it into linux-next yet.
> 
> Thanks!
> 
> 
> 

I like the concept with completion thing for this.
I have tired to stress test these patches with my mock
thermal zone module load/unload and it works good.

The test was doing the these bits:
for i in $(seq 1 1000000) ; do cat 
/sys/class/thermal/thermal_zone2/trip_point_0_temp > /dev/null 2>&1 ; done &
for i in $(seq 1 10000) ; do insmod /data/selftest_ipa.ko ; rmmod 
selftest_ipa ; done &

I couldn't trigger any issues in reading from this
trip temp file in background, which should go now w/o the
locking. I thought it would be nice test, since we have
direct call to trips array 'tz->trips[trip_id].temperature'.
Let me know if you think about other scenario for stress testing it.
(I have also checked the 'temp' sysfs read, where the mutex for
tz is used - also no issues).

Feel free to add to all patches:

Reviewed-and-tested-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz

