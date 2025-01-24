Return-Path: <linux-acpi+bounces-10810-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F351A1B197
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 09:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7093AB59C
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B303218ACA;
	Fri, 24 Jan 2025 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i9jEOpSl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pMQDqABw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1F614A0A3;
	Fri, 24 Jan 2025 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737707016; cv=none; b=SnP0ajGALuiqO0WT+WG93uQkUQUfnCAvEDRmIJ1Y5VpcgkD1Mf+ys2J/BmcDDRyvoKiXYoTh2Orw9Xigin5K4TsMTSmE9DNGq2OzyIiXkJysnTBMA1O6K42i99pZ1XzyzU4RCgQIFvx3XUlbhUTjo5VBgTbYJItmnTzbMuja6nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737707016; c=relaxed/simple;
	bh=u8jAzB9luBerrGnpeGITarnZaJCCRoOJb/od4Hjllpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g+mbdhZMSI9L4I87bhTo2jGv6i0dxIkUYYJYnOU6BbJTms+Bkm0EXf5esf64JGrGdrX/b8kqQu05kfvM18INsR63uhlDFTGeC0AQEVMQ3uzgL9JCUtFUbVnv2iswOglFzjur5g+gAjglE9chNQI60vFVGtSs17ZgOUYK5zfyhWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i9jEOpSl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pMQDqABw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737707006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u8jAzB9luBerrGnpeGITarnZaJCCRoOJb/od4Hjllpw=;
	b=i9jEOpSlMDa2M2CguNXrvcShhPwQvjlHcNjbhAxszqsE1ZLGPXP266X0JBDQz7pxLV4uAV
	r1L9+pNn702PPlVAFuS276P7OuxUcXCxqOfBOszvygqCwlU908x7csK9kaSe5/y4vvCMN+
	VDnzd02JIiXOcbVoY2VUXlL++RUj52KBwurmUfOZ0PmAwoFUPf+mr4+z6/2asXRV6Mo84F
	txL+8/bPI4IAYFRb9F5Eyovj394vLtg+ayDFSCURmy1Xd26+Mrw530IQtM1YNjC97PKg7y
	cTCZAht8wG1tMHbix6+6r/kT2duTdY0P3RYEQNbzCs8ozHcOpO0PS4zEm052BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737707006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u8jAzB9luBerrGnpeGITarnZaJCCRoOJb/od4Hjllpw=;
	b=pMQDqABwiuVQ1xLjoOG1BKQr79T6gUJst6Ow1ws4I0tdfzmF4P8vCd9YWK96ANqOf+S8XU
	2joppHKcBeE8MhBg==
To: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, dave.hansen@linux.intel.com, bp@alien8.de
Cc: rafael@kernel.org, lenb@kernel.org, mingo@redhat.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 jmattson@google.com, x86@kernel.org
Subject: Re: [PATCH V2] x86/acpi: Fix LAPIC/x2APIC parsing order
In-Reply-To: <CAJZ5v0iy63VakygnMqV4b5yYR2rwGbJ4zM4PbPYX2oH-ry9Evw@mail.gmail.com>
References: <20250117081420.4046737-1-rui.zhang@intel.com>
 <CAJZ5v0iy63VakygnMqV4b5yYR2rwGbJ4zM4PbPYX2oH-ry9Evw@mail.gmail.com>
Date: Fri, 24 Jan 2025 09:23:25 +0100
Message-ID: <87v7u48vsy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 23 2025 at 20:12, Rafael J. Wysocki wrote:
>> 1. https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#madt-processor-local-apic-sapic-structure-entry-order
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Jim Mattson <jmattson@google.com>
>> Closes: https://lore.kernel.org/all/20241010213136.668672-1-jmattson@google.com/
>> Fixes: ec9aedb2aa1a ("x86/acpi: Ignore invalid x2APIC entries")
>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>> Reviewed-by: Jim Mattson <jmattson@google.com>
>> Tested-by: Jim Mattson <jmattson@google.com>
>> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>
> x86 folks, should I apply this?

Sure.


