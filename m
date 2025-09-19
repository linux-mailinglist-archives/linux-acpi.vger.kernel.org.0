Return-Path: <linux-acpi+bounces-17144-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B31AEB8AF7D
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 20:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790355A6DBA
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 18:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69C925B30D;
	Fri, 19 Sep 2025 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdZpEpqc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E31E3DE5;
	Fri, 19 Sep 2025 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307445; cv=none; b=j47ZQFuVWca1+UBFEcz3AF41W1gbkws6M98c4aJ68EbiStO+GVkrFMovDfGGKVYXsGJIJzZpMcRCQWY5/4DxWy5i2g/53aEJ/6Ds5wkgw2KMkIhIw1Uv+vJDNfHdslLohkRolw0TmoEQJuB/C2PgdVLNrfY/L57vDAocBI/4EjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307445; c=relaxed/simple;
	bh=xjmkBtPn6HuBvnkLMMSI4a877Im/zN+aQsI8NzXwieU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkS/+PtnexizUum1yrBrFyPLVnxQslrJWQplhUBRXIbGEPmyxxrvpjvnL/q2Qdqzg3Tr+W+Atgj54GJUwUA0feCxgQe5nkHp/twDi9sCrOlPik/OLJ3VAjwkTfB0lnerMgVG40m+mwT4j1U1bmuhflhpwU1A76Iq+CYlDyzAdrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdZpEpqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97583C4CEF0;
	Fri, 19 Sep 2025 18:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758307445;
	bh=xjmkBtPn6HuBvnkLMMSI4a877Im/zN+aQsI8NzXwieU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XdZpEpqcnrs/UYhCuhUo7NrEXP3R9WyXlxwmwKDr24J+WUwQyE9JrbiqCrzvxeN3z
	 N4qRbuSxPSMG8zgcZS+055+iezOuRwzhcJWqXVXiH/xqFWEi6Ox56dbJzuUJpMK8c3
	 UyV/jEhkpfmwVXnviJqMhy0lzcCky+Jl9XrX/3AksFxZHRAEDdzu3v4Y1e6equCETb
	 QINieGflNNJ/wMpWbYIML1WAQ/ZVmyKHEe8HdLs4D5wlwXdxYwROapArpltu9xoc4T
	 S9aFO+likr7tVHECZpNvCrZdPZDSMXj+HS8vYCFl3+3wP+H0sHkAmolQvtYDQPuvzf
	 Iy8vWmvAVTHqA==
Message-ID: <c4fe5b92-1517-4b80-ba1b-f084b648a6c0@kernel.org>
Date: Fri, 19 Sep 2025 13:44:03 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] ACPI: processor: idle: Fix and cleanup
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Huisong Li <lihuisong@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
References: <5926523.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <5926523.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/18/2025 4:07 PM, Rafael J. Wysocki wrote:
> Hi All,
> 
> One of the recent changes forgot to update a cpuidle driver check in the
> ACPI processor driver, so fix this (first patch).
> 
> In addition, redefine two functions whose return values are ignored as
> void (second patch).
> 
> Thanks!
> 
> 
> 

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

