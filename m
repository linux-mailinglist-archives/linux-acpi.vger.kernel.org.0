Return-Path: <linux-acpi+bounces-16523-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 713B3B4A7F7
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 11:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FC0E4E288A
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 09:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EE62D0C61;
	Tue,  9 Sep 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eJlTKMmz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kht2FRWA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E12D060D;
	Tue,  9 Sep 2025 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409899; cv=none; b=jPm6CaxqxyYg3KSH5fwukWh8hNLA+N4tJdon7h/IzamROS1k313ucwt/Bxh1eoEI4DuNIfOWUwA2n1Roo1nyc0gxEFUQrJgdGId5l0bau7PvuwcjkeRn76a89U5GUgkIP9thIKSjNrPwkRlpaDfw69G9vwa4xKgLT26kvKgGwcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409899; c=relaxed/simple;
	bh=4cA0YleqjzJdmn1dgYmbQi15ckOY1berA8BmhMoXdi0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xz7xTf5PEdEmdv0N2Z0lqp76AT0Uc8SIjOFuQSAENpw1Rvdw8FN9ofAEFtaIU9Gx1zvB08ebAAE7sVoJf6Skiy83KB75q/OOD987j1jSBbfIbNgflX3Vm09SwF74C89irJkJsA2Vvzgh6S2waKHWRJZIksKlF3A95ybVLjD/YlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eJlTKMmz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kht2FRWA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757409894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjI8yLNL46JujTBVdfX+1NUIEG5NdqCM6d/7sSAIi0g=;
	b=eJlTKMmzYZpLew34qSC9s68db8VsN2gT8IlLEawPBkgsOS7Cxe1kSusXwKtr4hv3eG09Xu
	QzGxljkjGppHekS+NzfHi28Z3nCxurshaYdXEsNsAnP9BAF5OfJ4mtxOPaw2E5CIra9q+X
	yu+SECkaR29SOvnEvLVqUL/ZRByXk0FO93BfP/sfyGkpP82KKtJmXxXYg/cmO/9r4MWuIl
	huhNsslAE5R+87wQlEMETevRjrZbVotNktOD9ylriNM3nMxUbgasSvrX1zwRMkMEIDkNkw
	q3e+YsAce/tVuVYn6TERtP/sHAnfcPtcdov+itM2E30TaRXq6uGtzHiSyMUT7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757409894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjI8yLNL46JujTBVdfX+1NUIEG5NdqCM6d/7sSAIi0g=;
	b=kht2FRWAE5xLDAwQEQQL2CWiSg5araebssnmf7Dh13rxG9eZFdDbUcKWCC51hkCZfhygQG
	XoZurdLKyUkkGeAg==
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sven Peter <sven@kernel.org>, Janne Grunau
 <j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark
 <james.clark@linaro.org>
Subject: Re: [PATCH 01/25] irqdomain: Add firmware info reporting interface
In-Reply-To: <87ikhsvvau.ffs@tglx>
References: <20250908163127.2462948-1-maz@kernel.org>
 <20250908163127.2462948-2-maz@kernel.org> <87ikhsvvau.ffs@tglx>
Date: Tue, 09 Sep 2025 11:24:53 +0200
Message-ID: <87frcwvuze.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 09 2025 at 11:18, Thomas Gleixner wrote:
> On Mon, Sep 08 2025 at 17:31, Marc Zyngier wrote:
>> +int irq_populate_fwspec_info(struct irq_fwspec_info *info)
>> +{
>> +	struct irq_domain *domain;
>> +
>> +	domain = fwspec_to_domain(&info->fwspec);
>
> Just move that to the declaration line
>
>> +	if (!domain || !domain->ops->get_info) {
>> +		info->flags = 0;

It looks like @info is not initialized except for info::fwspec. That's a
patently bad idea.

Why has fwspec to be in info in the first place? What's wrong with doing
the obvious:

int irq_populate_fwspec_info(struct irq_fwspec *fwspec, struct irq_fwspec_info *info)
{
        memset(info, 0, sizeof(info));

        ....

No?

Thanks,

        tglx




