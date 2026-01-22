Return-Path: <linux-acpi+bounces-20556-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BYlOXM/cmnpfAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20556-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 16:17:07 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9204E688DE
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 16:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CC487A8154
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 13:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1665339B37;
	Thu, 22 Jan 2026 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b="BBucjTdG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sg-1-35.ptr.blmpb.com (sg-1-35.ptr.blmpb.com [118.26.132.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9D322C67
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089722; cv=none; b=o9pPDK2J6/75o0FcaExQ6QT8Da1BphXTu7SshTv3wm86D+Ew9Gx/A1lbRLaJu94pQRwsatjweLpQMvl/2Ht8uL9t2AsFTxf0JhlxVhZu206QVIn8PM3Oi/gKMiB+UqpCg7sWemlWkvGNNpqlLZ75leTckXfxLxZ+X1VmwHjoECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089722; c=relaxed/simple;
	bh=MxpgorCASj+kbR070LnJqHrDqVFszt3cTg6nRBtxNuM=;
	h=From:Subject:Content-Type:In-Reply-To:Date:Message-Id:
	 Mime-Version:References:To:Cc; b=E66Yl7xLeSJBcu10c5bM9Co++Fi/yBQ+AfTSwmYvkPmyQHZtVO1538JQM+iSHeTgs2ItY2YpMoPseQ4pU600gnLF4ylQlvxK73nO5T7AJ9ZKXKToecOPq3Raih/9kBC71E/YSE9Mqr0jThHOxY/c7YzXmsxY7CeFUoNaWWiBaik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b=BBucjTdG; arc=none smtp.client-ip=118.26.132.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=picoheart-com.20200927.dkim.feishu.cn; t=1769089712;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=TODsxxuFeJVkCe8LIZIipx2CnPyf3RHsGb/quE/s81E=;
 b=BBucjTdGRUcEiHdHjiy0dSVC07wDwcplPkkGyq/RQkaodyF1LGvvKwOT0z39A6mS2qlXss
 18fQtdZ4qcg3daM54DdqymbdZOkaxcYmaO+2wscdo2HxtlfwUKPXvTRJ0nn8X4izneIPst
 eYD7MTaR+oAGBNewAkJhlInsNCm/kUGa0OtXMs+Ztvi8HLt5qczipENLnt09V7fJeYaGjj
 hQhP6ocJbP9rS+ayFf0iFDNQ/CLvbfCEQE/mUEvS7mjMQO+UkOdcmEyX+57RCf+MwkWwil
 2U2Hwo/uQDq4JgYVTJUH5mg52wPuZrD7KpAEVa8VS031R0qStbKG0JSPzeNgsg==
Received: from [172.16.153.176] ([58.250.122.114]) by smtp.feishu.cn with ESMTPS; Thu, 22 Jan 2026 21:48:30 +0800
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Subject: Re: [PATCH 1/2] ACPI: scan: Use async schedule function for acpi_scan_clear_dep_fn
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+269722aaf+adeb96+vger.kernel.org+yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAJZ5v0j+yFhD6Y-LeY5eLSdXKyXQtC6q=TT-a79LnLpO_zoODw@mail.gmail.com>
Date: Thu, 22 Jan 2026 21:48:27 +0800
Message-Id: <6ac7b51b-376e-4fa9-a7a9-dc0f5da90f64@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122073446.45628-1-yang.yicong@picoheart.com> <20260122073446.45628-2-yang.yicong@picoheart.com> <2026012214-dinginess-improper-9bc1@gregkh> <ca98b360-ea68-4edc-af3e-0a3f4f87fc21@picoheart.com> <CAJZ5v0j+yFhD6Y-LeY5eLSdXKyXQtC6q=TT-a79LnLpO_zoODw@mail.gmail.com>
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: <yang.yicong@picoheart.com>, "Greg KH" <gregkh@linuxfoundation.org>, 
	<lenb@kernel.org>, <tglx@kernel.org>, <dakr@kernel.org>, 
	<akpm@linux-foundation.org>, <apatel@ventanamicro.com>, <pjw@kernel.org>, 
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, 
	<geshijian@picoheart.com>, <weidong.wd@picoheart.com>, 
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[picoheart-com.20200927.dkim.feishu.cn:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[picoheart.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20556-lists,linux-acpi=lfdr.de];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yang.yicong@picoheart.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[picoheart-com.20200927.dkim.feishu.cn:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[picoheart.com:mid,picoheart.com:email,picoheart-com.20200927.dkim.feishu.cn:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 9204E688DE
X-Rspamd-Action: no action

On 1/22/26 9:21 PM, Rafael J. Wysocki wrote:
> On Thu, Jan 22, 2026 at 1:43=E2=80=AFPM Yicong Yang <yang.yicong@picohear=
t.com> wrote:
>>
>> On 1/22/26 6:29 PM, Greg KH wrote:
>>> On Thu, Jan 22, 2026 at 03:34:45PM +0800, Yicong Yang wrote:
>>>> The device object rescan in acpi_scan_clear_dep_fn is scheduled
>>>> in the system workqueue which is not guaranteed to be finished
>>>> before entering userspace. This will cause the problem that
>>>> some key devices are missed when the init task try to find them,
>>>> e.g. console devices and root devices (PCIe nvme, etc).
>>>> This issues is more possbile to happen on RISCV since these
>>>> devices using GSI interrupt may depend on APLIC and will be
>>>> scanned in acpi_scan_clear_dep_queue() after APLIC initialized.
>>>>
>>>> Fix this by scheduling the acpi_scan_clear_dep_queue() using async
>>>> schedule function rather than the system workqueue. The deferred
>>>> works will be synchronized by async_synchronize_full() before
>>>> entering init task.
>>>>
>>>> Update the comment as well.
>>>>
>>>> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
>>>> ---
>>>>  drivers/acpi/scan.c | 35 ++++++++++++++++-------------------
>>>>  1 file changed, 16 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>>> index 416d87f9bd10..bf0d8ba9ba19 100644
>>>> --- a/drivers/acpi/scan.c
>>>> +++ b/drivers/acpi/scan.c
>>>> @@ -5,6 +5,7 @@
>>>>
>>>>  #define pr_fmt(fmt) "ACPI: " fmt
>>>>
>>>> +#include <linux/async.h>
>>>>  #include <linux/module.h>
>>>>  #include <linux/init.h>
>>>>  #include <linux/slab.h>
>>>> @@ -2365,39 +2366,35 @@ struct acpi_scan_clear_dep_work {
>>>>      struct acpi_device *adev;
>>>>  };
>>>>
>>>> -static void acpi_scan_clear_dep_fn(struct work_struct *work)
>>>> +static void acpi_scan_clear_dep_fn(void *dev, async_cookie_t cookie)
>>>>  {
>>>> -    struct acpi_scan_clear_dep_work *cdw;
>>>> -
>>>> -    cdw =3D container_of(work, struct acpi_scan_clear_dep_work, work)=
;
>>>> +    struct acpi_device *adev =3D to_acpi_device(dev);
>>>>
>>>>      acpi_scan_lock_acquire();
>>>> -    acpi_bus_attach(cdw->adev, (void *)true);
>>>> +    acpi_bus_attach(adev, (void *)true);
>>>>      acpi_scan_lock_release();
>>>>
>>>> -    acpi_dev_put(cdw->adev);
>>>> -    kfree(cdw);
>>>> +    acpi_dev_put(adev);
>>>>  }
>>>>
>>>>  static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
>>>>  {
>>>> -    struct acpi_scan_clear_dep_work *cdw;
>>>> -
>>>>      if (adev->dep_unmet)
>>>>              return false;
>>>>
>>>> -    cdw =3D kmalloc(sizeof(*cdw), GFP_KERNEL);
>>>> -    if (!cdw)
>>>> -            return false;
>>>> -
>>>> -    cdw->adev =3D adev;
>>>> -    INIT_WORK(&cdw->work, acpi_scan_clear_dep_fn);
>>>>      /*
>>>> -     * Since the work function may block on the lock until the entire
>>>> -     * initial enumeration of devices is complete, put it into the un=
bound
>>>> -     * workqueue.
>>>> +     * Async schedule the deferred acpi_scan_clear_dep_fn() since:
>>>> +     * - acpi_bus_attach() needs to hold acpi_scan_lock which cannot
>>>> +     *   be acquired under acpi_dep_list_lock (held here)
>>>> +     * - the deferred work at boot stage is ensured to be finished
>>>> +     *   before entering init task by the async_synchronize_full()
>>>> +     *   barrier
>>>> +     *
>>>> +     * Use _nocall variant since it'll return on failure instead of
>>>> +     * run the function synchronously.
>>>>       */
>>>> -    queue_work(system_dfl_wq, &cdw->work);
>>>> +    if (!async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->dev=
))
>>>> +            return false;
>>>
>>> This really feels wrong to me, you are taking a code path that has been
>>> working for quite a while and changing it.  Perhaps your system ACPI
>>> tables are the thing that is incorrect here?
>>>
>>> What exactly is the problem that you are seeing?  Why not start with
>>> that and then we can work out how to solve that issue?
>>>
>>
>> two issues here we met (as briefly mentioned in the commit and cover let=
ter):
>> 1. kernel panic due to userspace init cannot have an opened console. the
>>    console device scanning is queued in the system_dfl_wq in above code
>>    and not finished by the time userspace init process running, thus by
>>    the time userspace init running, no console is created
>> 2. entering rescue shell due to no root devices (PCIe nvme in our case)
>>    found. same reason as above, the PCIe host bridge scanning is queued
>>    in above and finished after init process running.
>>
>> The reason why these devices are created here is because they both depen=
d
>> on riscv-aplic irqchip to serve their interrupts (console's wired
>> interrupt and PCI's INTx interrupts) and in order to keep the dependency
>> these devices are scanned and created after riscv-aplic initialized. The
>> riscv-aplic is initialized in device_initcall and invoke above codes for
>> the scan/creation of these devices, it's close to the time running
>> userspace init process. Since system_dfl_wq is used here and no synchron=
ized
>> mechanism, the issues will happen if userspace init runs before these de=
vices
>> are ready.
>=20
> Well, there is flush_workqueue(), isn't it there?
>=20

sure, of course. I implement it using async schedule but open to any
better ones. but..

>> Previous solution [1] is to advance the initialization of riscv-aplic
>> earlier but the order still cannot be guaranteed conceptually.
>> With async_schedule_dev_nocal() the work queued is finished
>> before entering userspace init since we'll wait for completion at
>> async_synchronize_full() before executing userspace init process.
>>
>> To solve the issue I think we should make these devices ready before
>> entering userspace and async schedule is one way to make it. It's also
>> using an unbound workqueue but have additional synchronization. Any
>> corrections or suggestions?
>=20
> You can flush the dedicated workqueue at the same spot where you do
> async_synchronize_full(), can't you?
>=20

the async_synchronize_full() is already there in the init code right
before entering usersapce [1] so if we use async schedule we don't
need to add synchronize spot ourselves. For a dedicated workqueue we
need to call flush_workqueue() explicitly somewhere (I suppose to be
the last level initcall like late_initcall_sync). Furthermore we need
to allocate it and I think not all the platforms need this piece of
code.

It seems no need to have a dedicated workqueue for this since async
schedule can satisfy the needs already (from my view). Except less
modifications can be made for this piece of code if we use a dedicated
workqueue, is this the consideration and mandatory?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/init/main.c?h=3Dv6.19-rc6#n1580

thanks.

