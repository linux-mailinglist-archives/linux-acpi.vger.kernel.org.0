Return-Path: <linux-acpi+bounces-11211-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CA9A388BB
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Feb 2025 17:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B50189B032
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Feb 2025 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630BF22652E;
	Mon, 17 Feb 2025 15:54:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBBC225765;
	Mon, 17 Feb 2025 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807652; cv=none; b=QPZQe1l4rApP1swGpTjLzuwQ5NLyIAxlbVJhL3HloGRksYhNlpGOGcfLeaZuI/fKDeUAGaGuTb8BMjposH9f618L7eG3UOBlOzRf449XDQSHZr5jUUQAXfk+2zjzJtDmTUHzjSywz70XOLbgImkxl/v55SH47jmruLgfYmM5Gxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807652; c=relaxed/simple;
	bh=H3L0Az34g0Gjf+JmwUQ+3aVMdUV56LWsuxIojQEaL2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwNEvwYIKQat/sg6CSJucaUex4OdHxQcgxqBGii4D1nNn7qVo4WXcgE7bCTMNUpw935+R3JO21al/Xj/5mrq4hC3ok63FYPVtSpHHMUKkAQG133TUwdvPsuGI6z//tKw36etCVFy6RJK9SiEo9HOzGgcuqrpJQNSRmvGQqPCs3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 711B1152B;
	Mon, 17 Feb 2025 07:54:29 -0800 (PST)
Received: from [10.122.18.64] (unknown [10.122.18.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16B233F5A1;
	Mon, 17 Feb 2025 07:54:10 -0800 (PST)
Message-ID: <3f540748-8d17-46bf-b613-9caae597a926@arm.com>
Date: Mon, 17 Feb 2025 09:54:09 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] tpm_crb: refactor check for idle support into TPM
 into inline function
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250214002745.878890-1-stuart.yoder@arm.com>
 <20250214002745.878890-3-stuart.yoder@arm.com> <Z678TKuFTJ4vgHqH@kernel.org>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <Z678TKuFTJ4vgHqH@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/14/25 2:18 AM, Jarkko Sakkinen wrote:
> On Thu, Feb 13, 2025 at 06:27:42PM -0600, Stuart Yoder wrote:
>> Refactor the two checks for whether the TPM supports idle into a single
>> inline function.
>>
>> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
>> ---
>>   drivers/char/tpm/tpm_crb.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
>> index ea085b14ab7c..d696226906a2 100644
>> --- a/drivers/char/tpm/tpm_crb.c
>> +++ b/drivers/char/tpm/tpm_crb.c
>> @@ -115,6 +115,16 @@ struct tpm2_crb_pluton {
>>   	u64 reply_addr;
>>   };
>>   
>> +static inline bool tpm_crb_has_idle(u32 start_method)
>> +{
>> +	if ((start_method == ACPI_TPM2_START_METHOD) ||
> 
> Unnecessary parentheses in each condition.
> 
>> +	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
>> +	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
>> +		return false;
>> +	else
>> +		return true;
>> +}
> 
> Could be just plain
> 
> /*
>   * Returns true, if the start method supports idle.
>   */
> static inline bool tpm_crb_has_idle(u32 start_method)
> {
> 	return start_method == ACPI_TPM2_START_METHOD ||
> 	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD ||
> 	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC;
> }

Will do that cleanup.

Thanks,
Stuart

