Return-Path: <linux-acpi+bounces-14240-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4DAAD1E12
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 14:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A3B1887BD5
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 12:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD24C20E003;
	Mon,  9 Jun 2025 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZkx9DSa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C9F13635C;
	Mon,  9 Jun 2025 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749473337; cv=none; b=Q6JvgVsV4ICddFNHtbMTp8EY39rsASnwdPTJyNhld5ZrZbO9EMa0/vlMpkgsmoa/YOd4FXHZuSU/ucyPF0BDW+CZZGQKtDeUmF/FWWGKVdKra2NZUecRi3fV5Guqp4kbZWXTSUa6E/oB/hQ8g6Xsl8pbcH8wC2tAtll0J3d2cd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749473337; c=relaxed/simple;
	bh=WR2KXlOgsqQgLa9D+uPDkUMVazhEh528GadISJQueX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGlCPox7tRGBP692pGUBateh5rMQDioT8lTOulqXqV3rLnSgg6R5tb9Le4/w/fGghIcF0OY3m4f0vfv3Nvg76p4ZHNkybBYZOKD1GVBXCX4uA1zw+SYDz6Q0YcZjjPzFOE2uUXD8WsJL7cVEqObDnrGj2hbTcsC65vUBBBtdRko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZkx9DSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E2CC4CEEB;
	Mon,  9 Jun 2025 12:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749473337;
	bh=WR2KXlOgsqQgLa9D+uPDkUMVazhEh528GadISJQueX8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mZkx9DSatDLF2EXFyCp4EdcC3Lw1MF1ev55aH+u8Fa+dJXiCKjDGBwptLV+QRtuW0
	 tiCiGwbskn2chFqjPI+xpdadKDoN45mrSxJ7cIc70WAnxJKnR0lakr9wscEI3K6kJ4
	 yXmTkSdFIZtdFaL8L3dNe45usWGHszaJSCRNZ3iEZcwZS3MFsJ3PoWJq7/4oujd392
	 hq+6xnBHyN1/pvbw0TCjoFvJ9CGOZzQugUJlq5yJlVRExp0i6XiilUoSqg7U9mf9Jv
	 cGxT12Ngyq7thwb8Bt9PGRLS9dOXirHr03Mfz9EG76DXjGKDFIAUPXJmJYsA24SwK3
	 w2bA9t6PkKCyg==
Message-ID: <2825b98d-1bbf-4312-899d-c0eea0854d51@kernel.org>
Date: Mon, 9 Jun 2025 07:48:55 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Decrease `AcpiExTracePoint` verbosity
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mario.limonciello@amd.com, robert.moore@intel.com,
 rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20250609032839.525087-1-superm1@kernel.org>
 <CAJZ5v0iNoT79e9RRraifMY84oR8QAcSeYwk+=vaRSuB9mGmtAA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0iNoT79e9RRraifMY84oR8QAcSeYwk+=vaRSuB9mGmtAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/9/2025 4:31 AM, Rafael J. Wysocki wrote:
> On Mon, Jun 9, 2025 at 5:29 AM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Early in kernel boot pointers can't be used and so %p shows up
>> incorrectly:
>>
>> ```
>> extrace-0138 ex_trace_point        : Method Begin [0x(____ptrval____):\M460] execution.
>> ```
>>
>> Later in the boot %p works, but it's not really actually useful when
>> the pathname can resolve properly. Adjust the debug print so that if
>> the Pathname resolves that the pointer isn't also printed:
>>
>> ```
>> extrace-0138 ex_trace_point        : Method Begin [\M460] execution.
>> ```
>>
>> Link: https://github.com/acpica/acpica/pull/1013
>> Link: https://github.com/acpica/acpica/commit/bdc2a4e646f097b693aa60f1f2c4228d1e31b0d1
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> This is an ACPICA change, so it should be made upstream first unless
> there is a good enough reason to make it directly in Linux.  In which
> case that reason should be mentioned in the changelog.

The patches were from ACPICA (I included the links above).  I wasn't 
sure if it needed to be a manual application here or if you'll do it the 
next cycle.  If you're going to automatically do it then we can 
disregard this patch for now.

> 
>> ---
>>   drivers/acpi/acpica/extrace.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/extrace.c b/drivers/acpi/acpica/extrace.c
>> index d34497f3576a4..36934d4f26fb4 100644
>> --- a/drivers/acpi/acpica/extrace.c
>> +++ b/drivers/acpi/acpica/extrace.c
>> @@ -136,9 +136,9 @@ acpi_ex_trace_point(acpi_trace_event_type type,
>>
>>          if (pathname) {
>>                  ACPI_DEBUG_PRINT((ACPI_DB_TRACE_POINT,
>> -                                 "%s %s [0x%p:%s] execution.\n",
>> +                                 "%s %s [%s] execution.\n",
>>                                    acpi_ex_get_trace_event_name(type),
>> -                                 begin ? "Begin" : "End", aml, pathname));
>> +                                 begin ? "Begin" : "End", pathname));
>>          } else {
>>                  ACPI_DEBUG_PRINT((ACPI_DB_TRACE_POINT,
>>                                    "%s %s [0x%p] execution.\n",
>> --
>> 2.43.0
>>
>>


