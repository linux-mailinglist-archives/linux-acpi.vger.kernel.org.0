Return-Path: <linux-acpi+bounces-4910-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD378A23D7
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Apr 2024 04:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF17D2853B3
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Apr 2024 02:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09B814AA9;
	Fri, 12 Apr 2024 02:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BDohIcd+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165AC134BD;
	Fri, 12 Apr 2024 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712889705; cv=none; b=DBS0AWrYFXFmxc5wRVxEFZHbCViuLTKWyKCtYfYxRADglb8DjeGbRtM2WzBOUFDEkW4wjj6f5XVRnhZHEIs/YeM8YRHYX2UuB2GkhRfdE8YLnlc1NpFW7bndxFHg1EAGccizmZlCOY0OTC1Vpyc2ATkqyWp4YSaTRvYO8n/eGp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712889705; c=relaxed/simple;
	bh=kPTWyd27qtpz0j7CiJ8MLUsJpEDcMvRcWprNNYOooUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFnOoBMQGV8dIZ+HPHQCEN8hdjdteSAI5DgvAoonHia0SlSnm/WZrMRO+3cHf7wf6Ka6w/99fwq4uLXKibTqDZFHjsnG1QqkHaR1++252H8Sq1YWVlS7+/qM3SlkGOpHAGxp63munPYOaL6o8BxLQfUk/+2PUJI5yOI4Pe/psco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BDohIcd+; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712889693; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YjwBFUKfQzATV8MN0CZKmv5/RE4aS2y4MQlXc0URcto=;
	b=BDohIcd+BA1HWdfhgGDJAB4OvcRuI7Bm+8EGF0jJ3kxgDTZWRqtV6H2voAk90PRsZaJRHLsQBXgdXFba11+Jeb5m1zR7jdryVSmgFdvcwkMqcwSvhFHJm0fn6atpRyOQwowrId6DC/kycD9UfLkhihsPa7Gr66MuuRwohPm0bVU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4MgPBj_1712889692;
Received: from 30.221.130.139(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W4MgPBj_1712889692)
          by smtp.aliyun-inc.com;
          Fri, 12 Apr 2024 10:41:32 +0800
Message-ID: <8ff4deab-13ab-4fdf-b418-fbfefe46c087@linux.alibaba.com>
Date: Fri, 12 Apr 2024 10:41:31 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ACPICA: AEST: Support AEST V2
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240410063602.41540-1-tianruidong@linux.alibaba.com>
 <ZhZacAOVpAXK8lDE@bogus>
 <e3c91a7b-4bcc-45ce-92e6-c6a50ad80479@linux.alibaba.com>
 <Zhep-UCqqPlg9BIh@bogus>
Content-Language: en-US
From: Ruidong Tian <tianruidong@linux.alibaba.com>
In-Reply-To: <Zhep-UCqqPlg9BIh@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/11 17:14, Sudeep Holla 写道:
> On Thu, Apr 11, 2024 at 03:54:48PM +0800, Ruidong Tian wrote:
>>
>>
>> 在 2024/4/10 17:22, Sudeep Holla 写道:
>>> On Wed, Apr 10, 2024 at 02:36:00PM +0800, Ruidong Tian wrote:
>>>> AEST V2 was published[1], add V2 support based on AEST V1.
>>>>
>>>
>>> Any changes to ACPICA has to get merged in the external ACPICA project.
>>> Refer [1] for details from Rafael. You can also refer [2] in the kernel
>>> docs.
>>>
>>
>> Patch1 is just a fix to follow kernel code style.
> 
> IIUC such changes are not allowed as ACPICA changes are always imported
> from the external project. So you have to take same route as patch2

In ACPICA, all struct use typedef which is not allowed in kernel:

     It's a **mistake** to use typedef for structures and pointers[1].

I see all other structs in actbl2.h follow this rule, so I fix all 
typedef in AEST struct to follow kernel code style. But i can not apple 
this fix in ACPICA. Patch1 is just a kernel patch.

[1]: Documentation/process/coding-style.rst

> 1
>> Patch2 had merged to
>> acpica project, PR link can be see in patch2 comment:
>>
>>    Link: https://github.com/acpica/acpica/commit/ebb4979
> 
> Thanks, this will then get imported into kernel next time ACPICA changes
> get merged which usually happens regularly.
> 

