Return-Path: <linux-acpi+bounces-13401-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 124C1AA5555
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 22:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C551C2561B
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 20:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1DA296FB5;
	Wed, 30 Apr 2025 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="cIYp2AOr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3529553C
	for <linux-acpi@vger.kernel.org>; Wed, 30 Apr 2025 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043670; cv=none; b=j+Vki3KN4j2EMF348tzo+A1xkoMVElKquA6s465/spD5dAaSd3PJkgPOcUvc/YcY11s31W6upveOTLjMB6gHgGcEou0LFDLjFJzoTuI5N8LDjrsXL/dTvJRTb+kFWAqIj7IokKUrRQwUgHGx/q2x3jAzlga1UNeRUpEAsyMPGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043670; c=relaxed/simple;
	bh=/014ig/vOtXLleLlc5POQLGIpZfKag2WAJwe0NM0ssg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=twE5TvGVmh2UOUSaK2ziIVAZXXTczyFPJWAunChTIWq9jTJewE2BxZAYyBEFSKXXgxLkmKcrpgOeq0Ih/GwyYFSSwSb0BsrbPUXI+Ca8smnaNO826HY6RVcBBTee4QlS5Ubl7/6MAC2zF8Uh/wSlRUwawjx8fOfoitcRyAiUVoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=cIYp2AOr; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id A3qmuKhlCMETlADiduRQG5; Wed, 30 Apr 2025 20:07:47 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ADicuEFXCSYnJADicudAjj; Wed, 30 Apr 2025 20:07:47 +0000
X-Authority-Analysis: v=2.4 cv=FIkdxfos c=1 sm=1 tr=0 ts=68128313
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=oxfijZKff90vd35IHugA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h2tkyVN64pIV8hWBO6rBTclvumzy8P9/KwD3hFpi4zU=; b=cIYp2AOrhsxIemYqDaRuFpGrUh
	bJfgWLnX+phxwlnYRTtMhW7GEMI2zjMZjy2NEia5ZnZMzo/jDnxaap5ZuoYxRjdSHv712CVjFs/N5
	6gJtMU4fIwZmfBt+qdWXhqlbl4lPZWqMEnkGgTGonu2CnkeP7a17k+Kj9hGTphKfKtTiR+GT3m6c5
	9BHkWIrA24bJUVfJhv2EhbnygO5ySM2KcWosv3FrtpmWd93keddzE8HczLETO7riL0fuU/VxtIED/
	+bk+hxUCVEaZ9JCbxySs61qCBHLjxcAIY6nqdFO/UNKFUu/eROWKpgPuNLRUs0uLH4St//wyjSggv
	n+AZC9yg==;
Received: from [177.238.17.151] (port=47562 helo=[192.168.0.101])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uADib-00000003MZY-0Vw0;
	Wed, 30 Apr 2025 15:07:45 -0500
Message-ID: <c4828c41-e46c-43c9-a73a-38ce8ab2c1c4@embeddedor.com>
Date: Wed, 30 Apr 2025 14:07:24 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] acpi: nfit: intel: Avoid multiple
 -Wflex-array-member-not-at-end warnings
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Dan Williams <dan.j.williams@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>
Cc: nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z-QpUcxFCRByYcTA@kspp>
 <67e55ac4dfa2e_13cb29410@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <df338a70-fdfc-427e-9915-8b9e50de93ad@embeddedor.com>
Content-Language: en-US
In-Reply-To: <df338a70-fdfc-427e-9915-8b9e50de93ad@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.17.151
X-Source-L: No
X-Exim-ID: 1uADib-00000003MZY-0Vw0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.101]) [177.238.17.151]:47562
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHYiASDPMuxZH9ZXn5DmurGqy63orPTfpMNuEGIUZK6bVkVjvgH712GKhXwaaXM2TKwKFlLsgFBtBS7MQ2d3PV+EBSAjxe/aDGks4VIdI5ujfmXllMv3
 EgLzguW7ZRaLlCMQwqjpEUbguJ5UCKHpUCW6feG2aFQeJbz9DhtxyrNciIGKtLa38rthJyyujXhIN5wQW32Qx1Xr7a1+PQy3HfKo1m88gFoW/gbPR0akHmC3



On 30/04/25 13:41, Gustavo A. R. Silva wrote:
> 
> 
> On 27/03/25 08:03, Dan Williams wrote:
>> Gustavo A. R. Silva wrote:
>>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>>> getting ready to enable it, globally.
>>>
>>> Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
>>> a flexible structure where the size of the flexible-array member
>>> is known at compile-time, and refactor the rest of the code,
>>> accordingly.
>>>
>>> So, with these changes, fix a dozen of the following warnings:
>>>
>>> drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>> Changes in v2:
>>>   - Use DEFINE_RAW_FLEX() instead of __struct_group().
>>>
>>> v1:
>>>   - Link: https://lore.kernel.org/linux-hardening/Z618ILbAR8YAvTkd@kspp/
>>>
>>>   drivers/acpi/nfit/intel.c | 388 ++++++++++++++++++--------------------
>>>   1 file changed, 179 insertions(+), 209 deletions(-)
>>>
>>> diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
>>> index 3902759abcba..114d5b3bb39b 100644
>>> --- a/drivers/acpi/nfit/intel.c
>>> +++ b/drivers/acpi/nfit/intel.c
>>> @@ -55,21 +55,17 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
>>>   {
>>>       struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>>>       unsigned long security_flags = 0;
>>> -    struct {
>>> -        struct nd_cmd_pkg pkg;
>>> -        struct nd_intel_get_security_state cmd;
>>> -    } nd_cmd = {
>>> -        .pkg = {
>>> -            .nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
>>> -            .nd_family = NVDIMM_FAMILY_INTEL,
>>> -            .nd_size_out =
>>> -                sizeof(struct nd_intel_get_security_state),
>>> -            .nd_fw_size =
>>> -                sizeof(struct nd_intel_get_security_state),
>>> -        },
>>> -    };
>>> +    DEFINE_RAW_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
>>> +            sizeof(struct nd_intel_get_security_state));
>>> +    struct nd_intel_get_security_state *cmd =
>>> +            (struct nd_intel_get_security_state *)nd_cmd->nd_payload;
>>>       int rc;
>>> +    nd_cmd->nd_command = NVDIMM_INTEL_GET_SECURITY_STATE;
>>> +    nd_cmd->nd_family = NVDIMM_FAMILY_INTEL;
>>> +    nd_cmd->nd_size_out = sizeof(struct nd_intel_get_security_state);
>>> +    nd_cmd->nd_fw_size = sizeof(struct nd_intel_get_security_state);
>>
>> Can this keep the C99 init-style with something like (untested):
>>
>> _DEFINE_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
>>               sizeof(struct nd_intel_get_security_state), {
>>         .pkg = {
>>                 .nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
>>                 .nd_family = NVDIMM_FAMILY_INTEL,
>>                 .nd_size_out =
>>                         sizeof(struct nd_intel_get_security_state),
>>                 .nd_fw_size =
>>                         sizeof(struct nd_intel_get_security_state),
>>         },
>>     });
>>
>>
>> ?
> 
> The code below works - however, notice that in this case we should
> go through 'obj', which is an object defined in _DEFINE_FLEX().
> 
>          _DEFINE_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
>                          sizeof(struct nd_intel_get_security_state), = {
>                  .obj = {
>                          .nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
>                          .nd_family = NVDIMM_FAMILY_INTEL,
>                          .nd_size_out =
>                                  sizeof(struct nd_intel_get_security_state),
>                          .nd_fw_size =
>                                  sizeof(struct nd_intel_get_security_state),
>                  },
>          });
> 

Now, I can modify the helper like this:

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 69533e703be5..170d3cfe7ecc 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -404,7 +404,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
         union {                                                                 \
                 u8 bytes[struct_size_t(type, member, count)];                   \
                 type obj;                                                       \
-       } name##_u initializer;                                                 \
+       } name##_u = { .obj initializer };                                      \
         type *name = (type *)&name##_u

  /**

and then we can use the helper as follows:

         _DEFINE_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
                         sizeof(struct nd_intel_get_security_state), = {
                         .nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
                         .nd_family = NVDIMM_FAMILY_INTEL,
                         .nd_size_out =
                                 sizeof(struct nd_intel_get_security_state),
                         .nd_fw_size =
                                 sizeof(struct nd_intel_get_security_state),
         });

OK, I'll go and update the helper.

-Gustavo


