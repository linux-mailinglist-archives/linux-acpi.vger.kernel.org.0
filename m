Return-Path: <linux-acpi+bounces-7870-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98927960C99
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 15:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D42282811
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 13:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C5C1C462A;
	Tue, 27 Aug 2024 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AN6d+xLv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89D1C0DEC;
	Tue, 27 Aug 2024 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766753; cv=none; b=fEcDu5OUVuh/XAdoezBctUYRi2MZERJuNtVAgOKEsmLB5ZXNLbJavjzd1xprb1gYon4kPp/J76PrA2wjpyJ2CYEI917wBFsfMi/0guh2vY2aIrAfkFVLU7/R7/f9VfCpkwWUGPSU/DiV4JrgKw1HKf2KWplagbMOBuXbGmVmoFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766753; c=relaxed/simple;
	bh=8Q1OgVu1ZV4pADj3kH6liTryjhqWiTziReTFu0+p8n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsNGDGCKMrSvbZPRp2jLcSJpvIUT6XUCQ6+1RQDxTmayXwb20JH+l9/29AhNdj4VwxD/p+I8NTvUfr3/DivLQjYwr8lK2F28Lk13qaKJEFpdqI1FmnutGkPnywlmISc/kca9jnRcy86A+shl1sL+vFKFCjuWDoHIJDYvGcNygwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AN6d+xLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC80C61043;
	Tue, 27 Aug 2024 13:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724766752;
	bh=8Q1OgVu1ZV4pADj3kH6liTryjhqWiTziReTFu0+p8n8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AN6d+xLvIP0sscHmnVyE5H6qeuGv4Rbl769SEQOla/D/n0bparj4hGGOy/Pd4kH7g
	 hACHYMOPLJwSAVNs5efO4gYsf05EuB2wPiUDxcBvOVdj0t9hjmNN10/56AgbcjRo3T
	 Ww/3L+LdrHcVgUrXNvz/IhEG2yoMg+SWKsOS/gU8JdT6qvbqTmwPEBzAHYL/2XfZmD
	 VNbPE0ziTRyr3TqdiGnGD7a8r3R7A28BGIUIEPRFEb2hAmXbOb9AngTHh7ZAjIIAUh
	 KkwqwpDuy1X7PQxTDJU/Da5BXVcnqHjJ0WWUww8RLHSjD2s9BN0OZ1ok9DEUeFypni
	 5bvSm6uUdBXpA==
Message-ID: <cdd77270-3189-4fa9-9b4e-e443db5fb583@kernel.org>
Date: Tue, 27 Aug 2024 15:52:24 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] platform/surface: Add OF support
To: Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>
References: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
 <20240814-topic-sam-v3-3-a84588aad233@quicinc.com>
 <ZszrjQChQ2aS5YjV@surfacebook.localdomain>
 <4dab4f36-309d-4b95-8b01-84963ca08d16@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <4dab4f36-309d-4b95-8b01-84963ca08d16@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.08.2024 11:07 AM, Hans de Goede wrote:
> Hi Andy,
> 
> Thank you for the review.
> 
> Note this has already been merged though.
> 
> Still there are some good suggestions here for a follow-up
> cleanup patch.

Andy, Hans

Is it fine if I submit a fat "address review comments" patch, or should
I split it up per issue?

Konrad

