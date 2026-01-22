Return-Path: <linux-acpi+bounces-20565-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBcZNtBccmn5iwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20565-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 18:22:24 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F1E6B269
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 18:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E0D431F39C2
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 16:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A890F35B658;
	Thu, 22 Jan 2026 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b="QTwCeuna"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB92E0B6E
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099258; cv=none; b=kYoH7MY9URKMFiWKkYp9U1f8PbAcXLkM1QbgqN0Cb/R12vD0YsTRWylrjyjTGx6yKEF1OmFqniYxRBRD+A+fVtETAAwR0cCG+4V4oVyDtERsGejYkqAcaOGaHR/OyUjv+31EzkEsFrJaZwYqbCWWf0fBOa88ESyhRXZKUwDVk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099258; c=relaxed/simple;
	bh=ce/GZV5rWwwqBAKLtnP9Y/XYKZRKecxMrTswb7hroLc=;
	h=To:Subject:Content-Type:Cc:Date:Message-Id:In-Reply-To:From:
	 References:Mime-Version; b=CBcMW9nR1IyrPSMcJHvzixmUsgt6TdbWrs4FSVCe2eJygZ+LCjnunfSZXAgcEUSkA7AdZc1xYCm1gbKSAmCuhF9Zy5Ou5QsNVgs+AmSFx5iXOFdQLVtQSPghChpxZaGFpDzbZ6LQki2+tjfstmX+/x45T+pglmD9EXIgdhqKt6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b=QTwCeuna; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=picoheart-com.20200927.dkim.feishu.cn; t=1769099235;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=U7MB4FpHZelEJ2XB8A7sg4gOVxPkRT31k6DLTHL6+CA=;
 b=QTwCeunak5IU0e5MEmDbrndk/R75eS0XMJVoqxTwFJfo01PDg94pyfnEVafBpNOg+hCdNy
 70wGlYjc58V/LvlSKQgg6fQAFUM+3C/Y8o7eiezCghhex6DOfGG97y/MKEgxj9/OTm7HVQ
 9Va+0bShvbEhg2srTLen4WI2lWIwmEhVDjeksuUcluHqr+H6/7qqSo0OKBigrDzk0Ek+vl
 6nU3kpL0kJ8MGGSTfHTtMvZ2FP+3KUKpb4j9DDjipo0wFOubwIbGaTBIiTB2d4OgMtr1xS
 2gNTkObVbtZFhfV960SS6f2qnUB8EmHa78AkNJQIc/BBFqoIM0ZjtjtxrUnlwg==
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] ACPI: scan: Use async schedule function for acpi_scan_clear_dep_fn
X-Lms-Return-Path: <lba+269724fe2+8d61b1+vger.kernel.org+yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8
Cc: <yang.yicong@picoheart.com>, "Greg KH" <gregkh@linuxfoundation.org>, 
	<lenb@kernel.org>, <tglx@kernel.org>, <dakr@kernel.org>, 
	<akpm@linux-foundation.org>, <apatel@ventanamicro.com>, <pjw@kernel.org>, 
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, 
	<geshijian@picoheart.com>, <weidong.wd@picoheart.com>, 
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>
Date: Fri, 23 Jan 2026 00:27:10 +0800
Message-Id: <ed060e06-43f8-4d0c-8c98-9a14d22f8a63@picoheart.com>
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJZ5v0j6u+kWxq8XAAhkoQjBAW4xqfu-XepAULx1c8syp6N8hw@mail.gmail.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Received: from [192.168.0.105] ([163.125.181.65]) by smtp.feishu.cn with ESMTPS; Fri, 23 Jan 2026 00:27:13 +0800
References: <20260122073446.45628-1-yang.yicong@picoheart.com> <20260122073446.45628-2-yang.yicong@picoheart.com> <2026012214-dinginess-improper-9bc1@gregkh> <ca98b360-ea68-4edc-af3e-0a3f4f87fc21@picoheart.com> <CAJZ5v0j+yFhD6Y-LeY5eLSdXKyXQtC6q=TT-a79LnLpO_zoODw@mail.gmail.com> <6ac7b51b-376e-4fa9-a7a9-dc0f5da90f64@picoheart.com> <CAJZ5v0j6u+kWxq8XAAhkoQjBAW4xqfu-XepAULx1c8syp6N8hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[picoheart-com.20200927.dkim.feishu.cn:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[picoheart.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20565-lists,linux-acpi=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yang.yicong@picoheart.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[picoheart-com.20200927.dkim.feishu.cn:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,picoheart.com:mid,picoheart.com:email]
X-Rspamd-Queue-Id: 35F1E6B269
X-Rspamd-Action: no action

On 1/22/26 9:57 PM, Rafael J. Wysocki wrote:
> On Thu, Jan 22, 2026 at 2:48=E2=80=AFPM Yicong Yang <yang.yicong@picohear=
t.com> wrote:
>>
>> On 1/22/26 9:21 PM, Rafael J. Wysocki wrote:
>>> On Thu, Jan 22, 2026 at 1:43=E2=80=AFPM Yicong Yang <yang.yicong@picohe=
art.com> wrote:
>>>>
>>>> On 1/22/26 6:29 PM, Greg KH wrote:
>>>>> On Thu, Jan 22, 2026 at 03:34:45PM +0800, Yicong Yang wrote:
>>>>>> The device object rescan in acpi_scan_clear_dep_fn is scheduled
>>>>>> in the system workqueue which is not guaranteed to be finished
>>>>>> before entering userspace. This will cause the problem that
>>>>>> some key devices are missed when the init task try to find them,
>>>>>> e.g. console devices and root devices (PCIe nvme, etc).
>>>>>> This issues is more possbile to happen on RISCV since these
>>>>>> devices using GSI interrupt may depend on APLIC and will be
>>>>>> scanned in acpi_scan_clear_dep_queue() after APLIC initialized.
>>>>>>
>>>>>> Fix this by scheduling the acpi_scan_clear_dep_queue() using async
>>>>>> schedule function rather than the system workqueue. The deferred
>>>>>> works will be synchronized by async_synchronize_full() before
>>>>>> entering init task.
>>>>>>
>>>>>> Update the comment as well.
>>>>>>
>>>>>> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
>>>>>> ---
>>>>>>  drivers/acpi/scan.c | 35 ++++++++++++++++-------------------
>>>>>>  1 file changed, 16 insertions(+), 19 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>>>>> index 416d87f9bd10..bf0d8ba9ba19 100644
>>>>>> --- a/drivers/acpi/scan.c
>>>>>> +++ b/drivers/acpi/scan.c
>>>>>> @@ -5,6 +5,7 @@
>>>>>>
>>>>>>  #define pr_fmt(fmt) "ACPI: " fmt
>>>>>>
>>>>>> +#include <linux/async.h>
>>>>>>  #include <linux/module.h>
>>>>>>  #include <linux/init.h>
>>>>>>  #include <linux/slab.h>
>>>>>> @@ -2365,39 +2366,35 @@ struct acpi_scan_clear_dep_work {
>>>>>>      struct acpi_device *adev;
>>>>>>  };
>>>>>>
>>>>>> -static void acpi_scan_clear_dep_fn(struct work_struct *work)
>>>>>> +static void acpi_scan_clear_dep_fn(void *dev, async_cookie_t cookie=
)
>>>>>>  {
>>>>>> -    struct acpi_scan_clear_dep_work *cdw;
>>>>>> -
>>>>>> -    cdw =3D container_of(work, struct acpi_scan_clear_dep_work, wor=
k);
>>>>>> +    struct acpi_device *adev =3D to_acpi_device(dev);
>>>>>>
>>>>>>      acpi_scan_lock_acquire();
>>>>>> -    acpi_bus_attach(cdw->adev, (void *)true);
>>>>>> +    acpi_bus_attach(adev, (void *)true);
>>>>>>      acpi_scan_lock_release();
>>>>>>
>>>>>> -    acpi_dev_put(cdw->adev);
>>>>>> -    kfree(cdw);
>>>>>> +    acpi_dev_put(adev);
>>>>>>  }
>>>>>>
>>>>>>  static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
>>>>>>  {
>>>>>> -    struct acpi_scan_clear_dep_work *cdw;
>>>>>> -
>>>>>>      if (adev->dep_unmet)
>>>>>>              return false;
>>>>>>
>>>>>> -    cdw =3D kmalloc(sizeof(*cdw), GFP_KERNEL);
>>>>>> -    if (!cdw)
>>>>>> -            return false;
>>>>>> -
>>>>>> -    cdw->adev =3D adev;
>>>>>> -    INIT_WORK(&cdw->work, acpi_scan_clear_dep_fn);
>>>>>>      /*
>>>>>> -     * Since the work function may block on the lock until the enti=
re
>>>>>> -     * initial enumeration of devices is complete, put it into the =
unbound
>>>>>> -     * workqueue.
>>>>>> +     * Async schedule the deferred acpi_scan_clear_dep_fn() since:
>>>>>> +     * - acpi_bus_attach() needs to hold acpi_scan_lock which canno=
t
>>>>>> +     *   be acquired under acpi_dep_list_lock (held here)
>>>>>> +     * - the deferred work at boot stage is ensured to be finished
>>>>>> +     *   before entering init task by the async_synchronize_full()
>>>>>> +     *   barrier
>>>>>> +     *
>>>>>> +     * Use _nocall variant since it'll return on failure instead of
>>>>>> +     * run the function synchronously.
>>>>>>       */
>>>>>> -    queue_work(system_dfl_wq, &cdw->work);
>>>>>> +    if (!async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->d=
ev))
>>>>>> +            return false;
>>>>>
>>>>> This really feels wrong to me, you are taking a code path that has be=
en
>>>>> working for quite a while and changing it.  Perhaps your system ACPI
>>>>> tables are the thing that is incorrect here?
>>>>>
>>>>> What exactly is the problem that you are seeing?  Why not start with
>>>>> that and then we can work out how to solve that issue?
>>>>>
>>>>
>>>> two issues here we met (as briefly mentioned in the commit and cover l=
etter):
>>>> 1. kernel panic due to userspace init cannot have an opened console. t=
he
>>>>    console device scanning is queued in the system_dfl_wq in above cod=
e
>>>>    and not finished by the time userspace init process running, thus b=
y
>>>>    the time userspace init running, no console is created
>>>> 2. entering rescue shell due to no root devices (PCIe nvme in our case=
)
>>>>    found. same reason as above, the PCIe host bridge scanning is queue=
d
>>>>    in above and finished after init process running.
>>>>
>>>> The reason why these devices are created here is because they both dep=
end
>>>> on riscv-aplic irqchip to serve their interrupts (console's wired
>>>> interrupt and PCI's INTx interrupts) and in order to keep the dependen=
cy
>>>> these devices are scanned and created after riscv-aplic initialized. T=
he
>>>> riscv-aplic is initialized in device_initcall and invoke above codes f=
or
>>>> the scan/creation of these devices, it's close to the time running
>>>> userspace init process. Since system_dfl_wq is used here and no synchr=
onized
>>>> mechanism, the issues will happen if userspace init runs before these =
devices
>>>> are ready.
>>>
>>> Well, there is flush_workqueue(), isn't it there?
>>>
>>
>> sure, of course. I implement it using async schedule but open to any
>> better ones. but..
>>
>>>> Previous solution [1] is to advance the initialization of riscv-aplic
>>>> earlier but the order still cannot be guaranteed conceptually.
>>>> With async_schedule_dev_nocal() the work queued is finished
>>>> before entering userspace init since we'll wait for completion at
>>>> async_synchronize_full() before executing userspace init process.
>>>>
>>>> To solve the issue I think we should make these devices ready before
>>>> entering userspace and async schedule is one way to make it. It's also
>>>> using an unbound workqueue but have additional synchronization. Any
>>>> corrections or suggestions?
>>>
>>> You can flush the dedicated workqueue at the same spot where you do
>>> async_synchronize_full(), can't you?
>>>
>>
>> the async_synchronize_full() is already there in the init code right
>> before entering usersapce [1] so if we use async schedule we don't
>> need to add synchronize spot ourselves. For a dedicated workqueue we
>> need to call flush_workqueue() explicitly somewhere (I suppose to be
>> the last level initcall like late_initcall_sync). Furthermore we need
>> to allocate it and I think not all the platforms need this piece of
>> code.
>>
>> It seems no need to have a dedicated workqueue for this since async
>> schedule can satisfy the needs already (from my view). Except less
>> modifications can be made for this piece of code if we use a dedicated
>> workqueue, is this the consideration and mandatory?
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/init/main.c?h=3Dv6.19-rc6#n1580
>=20
> So please add the above information to the changelog of your patch
> (that is, why it is better to use async for this than to use a
> dedicated workqueue in your view) because it is kind of relevant.

sure. will add these in the commit in next version.

>=20
> And how does the second patch in the series depend on this one?

these two are independent patches but to fix the same class of issue.
this one is for the real issue we met and the second one is a theoretical
possible issue found during discussion on my previous solution. I may
send them separately since the second one maybe not a problem in real case,
will wait for more feedback.

thanks.

