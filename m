Return-Path: <linux-acpi+bounces-11072-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439E2A31843
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 22:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0081E3A7743
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 21:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A4C267B09;
	Tue, 11 Feb 2025 21:50:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895902676D0;
	Tue, 11 Feb 2025 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310653; cv=none; b=fHxHleaeUCihguw15eas2fHPHxYxmHQti7Nh1jeHOTSAhpyqqP8rKF2bSPLzGfoJ45ux7iyXQa63XeTgdA//Jli0hZxPnJSlmJ7G78/BjxYn8tj634tRPGMBy2XFmG2VcCwJVifE4tkA49LF83YTu9PGxj+GdI77SV1aqPtk7K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310653; c=relaxed/simple;
	bh=HxP5Sli4K3SAZa0mS2dzwncRLUQw35Zz0t/vyHKGVvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9i31YZuRfONlq+6JfB5jAug9WRBaHiQ4N/Q0KTyl0ITX3VtTtL2bzQv27N0bbA99e+a+2kRzhu8md/59+dURhSQqHGZ0lGv9uMZ2h+HsTCB90Stbnq07+5hzwwDkzvkgyLkAV1fu9dz/8xJ2nA8qzpanqQRzovq3VwSXBRtERw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D7011D14;
	Tue, 11 Feb 2025 13:51:12 -0800 (PST)
Received: from [10.118.111.35] (G9L3377F54.austin.arm.com [10.118.111.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E93B3F58B;
	Tue, 11 Feb 2025 13:50:50 -0800 (PST)
Message-ID: <8780f1e3-e0be-48e9-a329-2d48c5bef034@arm.com>
Date: Tue, 11 Feb 2025 15:50:50 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ACPICA: add start method for Arm FF-A
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-integrity@vger.kernel.org, jarkko@kernel.org, peterhuewe@gmx.de,
 jgg@ziepe.ca, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250210232227.97761-1-stuart.yoder@arm.com>
 <20250210232227.97761-4-stuart.yoder@arm.com> <Z6sfB-tvhNhTek-Y@bogus>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <Z6sfB-tvhNhTek-Y@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/11/25 3:57 AM, Sudeep Holla wrote:
> On Mon, Feb 10, 2025 at 05:22:26PM -0600, Stuart Yoder wrote:
>> Add TPM start method for Arm FF-A defined in the TCG ACPI
>> specification v1.4.
>>
> 
> ACPICA changes require (at least) a pull request to be submitted to
> the upstream ACPICA project on GitHub from where the changes get pulled
> into the kernel along with other changes.
> 
> If such a pull request is already created, please resend the Linux patch
> with a link pointing to that pull request to inform the maintainer about
> the same so that it helps in the review of the patches here.

I will submit the pull request to acpiaca and send the link when I send
v2 of this series.

Thanks,
Stuart


