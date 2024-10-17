Return-Path: <linux-acpi+bounces-8829-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3F89A16D8
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 02:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016532874F5
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 00:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94923214;
	Thu, 17 Oct 2024 00:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsZJxgoL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99576184D;
	Thu, 17 Oct 2024 00:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124318; cv=none; b=NmZRRR2XluCSSYPOg4qXlHqCJf9+GkMszvcYwyOZ0uJNXIusInYGdlOLO4tkwhBM1564qo/KDaYJjfx9KHPj7sYM7wR/HvUCtxLT6ATlsV+VnyQs2c8aQmkRGwEnxvQxkpp3qiW6MMeLv5bQel9GRsmccwWFSl7E3F4yvrtMcQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124318; c=relaxed/simple;
	bh=OzTbmdTqQGGLKUsWxLzxXEzX65Nn+CsiuuRBqCGzVJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbiGFsA3XyCoh/XNT4fGa0lACsF56cNJSmVN/xvBU1L6zS6j+ve39yvAIWvK8/HWISAWwD0sgTOShOnLRfvGsvpEA3DlK9BL+/Rh+AfT3ytRiprAhDCKVP86KHenbikrHn5qb4KxAZfHStS5xlz6XMKGa27h/iVYH+PRzSdZjn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsZJxgoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE96C4CEC7;
	Thu, 17 Oct 2024 00:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729124318;
	bh=OzTbmdTqQGGLKUsWxLzxXEzX65Nn+CsiuuRBqCGzVJE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nsZJxgoLMDhObNdr43Fn6WO15RlRZjrX64eprCGI3XLRXrinJAt4q4tKUy/klQfxq
	 zhhWwAx8IF/kH9PrwL2OjdLO6jraG7Th657uUG8+YrfmSamoTt4dSIkbfIITqPBk+m
	 ezP52WEMi3TsDNRVtC9h3doAiY71jdfc9b/d5svx0EfYd1DKvCaLU+rrTd815kdRXj
	 qstJbjBfkEE2f3C68ekfpYPMnI0s2iChPLd8f//u3MHgrtZ0KPTm+EowyLUM2r5Df0
	 TZVadpBmMWx81gQcjtMTxMjyxZQtrIer4kYjCc7liA5PtuZ29n7oaDZiUhGDLOSVCI
	 unVw63s1qFMdg==
Message-ID: <2ae2c852-6ac2-428d-8a65-496565be7ed0@kernel.org>
Date: Wed, 16 Oct 2024 19:18:34 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] Adjustments for preferred core detection
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: bp@alien8.de, gautham.shenoy@amd.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
 x86@kernel.org
References: <3b2195074d7c8fa20f93f1dc6fc25afe5dbb2909.camel@intelfx.name>
 <cb7fad8c-f288-410e-b380-1204b26930ad@kernel.org>
 <ed2a3efcb08af8286a5821acea8302164f0b0a35.camel@intelfx.name>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <ed2a3efcb08af8286a5821acea8302164f0b0a35.camel@intelfx.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/24 17:19, Ivan Shapovalov wrote:
> On 2024-10-16 at 17:06 -0500, Mario Limonciello wrote:
>> On 10/16/2024 17:03, Ivan Shapovalov wrote:
>>> Hi,
>>>
>>> On my desktop Zen 3 (Vermeer) system applying this series yields a new
>>> warning message on each boot:
>>>
>>>> Oct 16 06:20:41 kernel: Could not retrieve highest performance (-19)
>>>
>>> As I see it, this is one of the pr_debug()s newly promoted to warnings.
>>> Is there anything I can provide to help fix this?
>>>
>>
>> Open up a kernel Bugzilla and attach a full dmesg and all details.  You
>> can CC me directly to it and I'll look into it.
>>
>> Also ideally; can you please check 6.12-rc3.
>>
> 
> Alright, I'll do that once I build and test the -rc.
> 
> Besides dmesg+config+cpuinfo, are there any other details that you
> would like to see there?
> 
> Thanks,
>>

That's fine for now.  Depending on what we find we might want to look at 
an acpidump too.

