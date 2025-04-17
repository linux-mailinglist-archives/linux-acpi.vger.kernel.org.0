Return-Path: <linux-acpi+bounces-13092-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1499A91D15
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 14:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108893A58C7
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEA323E22B;
	Thu, 17 Apr 2025 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3xTdPdx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82231624DC;
	Thu, 17 Apr 2025 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894776; cv=none; b=Dvz+9Q/xMx4ru8ZQcV+vOcU1eMLCp3jltfn2xOvonf7/LUOol+9IBtbvXmyxTp98iptKiL2Df/0kBLNBQuOC/BCTKO1qGQM242vrnFq9+u+ZRkEdQ7Teea+85yBQBiiNYax/a9j0Kzt4uzoulk7yyEmcXuzXipHLtWRWXyRwwa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894776; c=relaxed/simple;
	bh=jfhcyfzC4xPLokNqq4SlJ2YDxS4rAc3iJ5EpVBW0tY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRWtkqfFZ5vSeks51KcOkq98MgDC5gra7wHHFZD8Z8iKX2TR/WwmBLtFchJ4DkarbihcQluaq9ae2qxyttNno29QsBRgbMFfzZJkgo0yKGhaZqF3YvhpfGRvvl6nA70mRXSdcLdFQc7K57+nw6SjUVO3BOS+Ddlmx9YBClw3s2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3xTdPdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456D9C4CEE4;
	Thu, 17 Apr 2025 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744894775;
	bh=jfhcyfzC4xPLokNqq4SlJ2YDxS4rAc3iJ5EpVBW0tY0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F3xTdPdxCkv34qNqpNOpomrPooiacraggjCelQp+g+UTt5vNbygtoBWXIcfmn87QS
	 yrCjlu3hrkUfzzpzzjFf+ZU1knxbZ3qOrTJuzVn0lI4x/cTFNicYVUusEEhSgk8AER
	 3/AYG7yOrIGD8uPLRcPQ+3wth43kpSDPOvODowgUgJrJW/Ksnv/mPMN7D392VZfADV
	 gC5SH2OwZvNe+EUd0aLYgrPLekU515mihHV3eBMXxvww3UXWlnT/DQevv9PIHgcH+W
	 ElV7gWjy0VZd+SEFJjrkw+CzAoFwVw+ralq/5dIC2HLQ9VNP4nQlzBu0YS/lG5wzTO
	 A1i88e1XkHJ7w==
Message-ID: <d00430dd-000f-4805-ab5d-d04affffa833@kernel.org>
Date: Thu, 17 Apr 2025 07:59:34 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPICA: Add support for printing AML arguments when
 trace point enabled
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mario.limonciello@amd.com, robert.moore@intel.com,
 rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20250417031040.514460-1-superm1@kernel.org>
 <CAJZ5v0iQMOY1NhpE9Hy0jD6iKQeFbdxB4ZWj5KZcsbApwZ_RhQ@mail.gmail.com>
 <90fcc29b-be8e-44b3-b6bb-a1ef06096520@kernel.org>
 <CAJZ5v0jRLRdcvTGELZswnNuQKQx_RuKvDAL776Qv49bP7vxKrQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0jRLRdcvTGELZswnNuQKQx_RuKvDAL776Qv49bP7vxKrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/17/2025 7:46 AM, Rafael J. Wysocki wrote:
> On Thu, Apr 17, 2025 at 2:03 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>>
>>
>> On 4/17/25 06:19, Rafael J. Wysocki wrote:
>>> On Thu, Apr 17, 2025 at 5:10 AM Mario Limonciello <superm1@kernel.org> wrote:
>>>>
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> When debug level is set to `ACPI_LV_TRACE_POINT` method start and
>>>> exit are emitted into the debug logs. This can be useful to understand
>>>> call paths, however none of the arguments for the method calls are
>>>> populated even when turning up other debug levels.
>>>>
>>>> This can be useful for BIOSes that contain debug strings to see those
>>>> strings. When `ACPI_LV_TRACE_POINT` is set also output all of the arguments
>>>> for a given method call.
>>>>
>>>> This enables this type of debugging:
>>>>
>>>> ```
>>>> extrace-0138 ex_trace_point        : Method Begin [0x0000000096b240c4:\M460] execution.
>>>> extrace-0173 ex_trace_args         :  "  POST CODE: %X  ACPI TIMER: %X  TIME: %d.%d ms\n", b0003f53, 1a26a8b2, 0, 15e, 0, 0
>>>> extrace-0138 ex_trace_point        : Method End [0x0000000096b240c4:\M460] execution.
>>>> ```
>>>>
>>>> Link: https://github.com/acpica/acpica/commit/08219d91b5678ae2fae6e4f208df790a4e108c1c
>>>
>>> The link doesn't work.
>>
>> Are you sure?
>>
>> I just tried again and it worked for me.
> 
> Yeah, it works now, I had to sign in to github.
> 
> But it is a link to a commit and I need a link to a PR.  I think it's this one:
> 
> https://github.com/acpica/acpica/pull/1012

Yes that's the right PR that led to the commit.  Can you swap it out? 
Or would you like me to resubmit with it adjusted?

