Return-Path: <linux-acpi+bounces-9897-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9119E1701
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 10:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959EC2838F3
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 09:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8721C1DE4DF;
	Tue,  3 Dec 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntHcuhQ6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F491D63EC;
	Tue,  3 Dec 2024 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217498; cv=none; b=XAG1HAoNjHT9AIo3hHWx5iCif5NpH0gol8VCJjqaBAB2Lwrs74nNpJYr9BBogc6V85SWxWlJVwSB34e9P2RwchuZ39C4+b4v0pOAoe1bn1Tr5tSn1hPkqKJnbqvUOUZeVk75/PrJ4FmmSbxFvMxlixMI7HUVpZJ3B3lFXG7wd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217498; c=relaxed/simple;
	bh=6BXbAOjCw5aBhHqklYbSDlSHWUFzfTiI55oePrqS2pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIXMT/ZWIyIKZhDGb+vZx2Ya+rC3rifL2DsDbpWvYXz8gBblqsHzljAHrZ1HwBvicg10Y57VegsVpnlh698qzuRqtuljqBaPMTnFCzGAvwSXK94R1O+hRA/X13X8lVCao03YT50gldGCEvXutdHx2Fta7OJ9j3uQACq122BXero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntHcuhQ6; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71d4e043dd9so2327158a34.1;
        Tue, 03 Dec 2024 01:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733217495; x=1733822295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3rH15lOfc44plaRCzN7FQcIPWREiXBgWt55OFo1yciQ=;
        b=ntHcuhQ6ujmbLUPSlJO0Ht7s61XUPZRoQEpbPMNG9hLnz+Z73iMz9DMAcmGrPBfReD
         cZUX29JiuMobb4EL/j0EnvMZDIcJ03NRJjxFsYvLou4q4dBZZFmpBaqjHd2ba0tjjul4
         sGs34ZzU/D8KKiyjh98kSTrKMDf8tr1vnTo7C4/kDzeFw5xj2FNxT+NH29uX/UALWyZi
         vvJ0y7+92zGTaIx7UxdK9xZO6393RD+m5axIuMv6NmOl/878d2xP6AZ2A781OzYrCTGb
         aC2KtRid9my+yQ591b/fLT2op/Wd2frMMrJOl/VQeF1+pDiNwGqtz2eP3VJupf8Vrw5B
         ARQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733217495; x=1733822295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rH15lOfc44plaRCzN7FQcIPWREiXBgWt55OFo1yciQ=;
        b=S7tLuP+TEiDE1spbYlGSXplcqhvAfvKDCTwYcM7KbHFJ39YSReUCc/5kc3gX9Xf1DX
         WkPkNCUNs7NznhesO8nkgjWtZPcUdoboHm2o0Mj8UDdyctSBi/OWxv9iFrBsqFYQJC9d
         EU/PciZq9xr6yVvFIYu9JKFXNknMScqZuYggSGE97dqJ8KmNUMSKchaiyA3nU52Yl5nH
         RHuLPAE1ttFIMfK0o/vXeHjOdYlr4Txfs13EnqX+WqeScU4lT2ZTP82rwxx6bNNyXPO5
         kkQsW6mBDB6KtY5jKmc2CHTHuBpOIv8q3PQBnDbkd3ftmQ+BgWFPhXJzM7nDxkDCy8E+
         sfWg==
X-Forwarded-Encrypted: i=1; AJvYcCVp9eYjY0k9rYbBVFhSLNZ97tjVcJx80xf9bXLngi3Uu1wjMSiVmieR1xliaDmuTEVyj5HHwCrbYNGHohtL@vger.kernel.org, AJvYcCWrsXgQhy9mU7G2XSIYonIbOQtHBsjoFCKFWCQBvvlta7DQEUSHj3xwhLETT8ueJrOpQRU8ceB7oBeh@vger.kernel.org
X-Gm-Message-State: AOJu0YwogBdyrudpdia+gEhS8YYO4UALuTXwgnZ+6G+Ej207EABn2rAY
	YTkGDYq5tPGukck3l4sJgFhB6YgjMC1XlUME7AtbUSw7lvSbb3CW
X-Gm-Gg: ASbGncvsRO7YY5gs8Ky67AjtRkyopS/T0h1V9Qjx7suWDYWSMHeNkoVvZUkdluoVktN
	VDKYdej9G2SRyJvg+ZXLfMrp2ZivgYpQ8vF5cRlRKiXYQXE6lm5l+S7gkWV2b0xGE//WzCq9Jdq
	MrG6jFZHicYClICrfv5SJokXv9LzyxFLWMne5T2lOVmlHTUCC5Ks2RrTZXrYp7ztSQ0XtfSPhsg
	BNqqkTWBKnWTb7zt6YR/Yu9SrIukoWV7T28qzT3v+aN+WVxkRM1JkP6DLlELZB+
X-Google-Smtp-Source: AGHT+IFCdQvpqgQFplX/66sYo3+F4QadcwYNDBOm5oyPuaoASMuYeKuCMbE6x08pAqORVgImfi7tWw==
X-Received: by 2002:a05:6830:648b:b0:717:fe2d:a4e4 with SMTP id 46e09a7af769-71dad6d27f0mr2281039a34.19.1733217494946;
        Tue, 03 Dec 2024 01:18:14 -0800 (PST)
Received: from [192.168.0.203] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c39f4d7sm8001378a12.69.2024.12.03.01.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 01:18:14 -0800 (PST)
Message-ID: <25cd49b5-eb6b-4c8f-899b-71005ef0c4c6@gmail.com>
Date: Tue, 3 Dec 2024 14:48:06 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] acpi: nfit: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl
To: Ira Weiny <ira.weiny@intel.com>, dan.j.williams@intel.com
Cc: vishal.l.verma@intel.com, dave.jiang@intel.com, rafael@kernel.org,
 lenb@kernel.org, nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
References: <20241118162609.29063-1-surajsonawane0215@gmail.com>
 <1813d5d3-6413-4a44-b3dd-a1be4762f839@gmail.com>
 <674ddfa6abc4d_3cb8e0294cf@iweiny-mobl.notmuch>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <674ddfa6abc4d_3cb8e0294cf@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/24 21:56, Ira Weiny wrote:
> Suraj Sonawane wrote:
>> On 11/18/24 21:56, Suraj Sonawane wrote:
> 
> [snip]
> 
>>>
>>>    drivers/acpi/nfit/core.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>>> index 5429ec9ef..a5d47819b 100644
>>> --- a/drivers/acpi/nfit/core.c
>>> +++ b/drivers/acpi/nfit/core.c
>>> @@ -454,8 +454,13 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>>>    	if (cmd_rc)
>>>    		*cmd_rc = -EINVAL;
>>>    
>>> -	if (cmd == ND_CMD_CALL)
>>> +	if (cmd == ND_CMD_CALL) {
>>> +		if (!buf || buf_len < sizeof(*call_pkg))
>>> +			return -EINVAL;
>>> +
>>>    		call_pkg = buf;
>>> +	}
>>> +
>>>    	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
>>>    	if (func < 0)
>>>    		return func;
>>
>> Hello!
>>
>> I wanted to follow up on the patch I submitted. I have incorporated all
>> the suggested changes up to v6. I was wondering if you had a chance to
>> review it and if there are any comments or feedback.
> 
> It just missed the soak period for the merge.  But I'll be looking at it
> for an rc pull request.
> 
> Thanks for sticking with it,
> Ira
> 
> [snip]
Thank you for the update.
I also appreciate everyone's efforts in reviewing the patch.
Thank you for reviewing the patch.

Best regards,
Suraj

