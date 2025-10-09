Return-Path: <linux-acpi+bounces-17686-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B924BCA372
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 18:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C9244E6CAD
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 16:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA25223DEC;
	Thu,  9 Oct 2025 16:42:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA57224B12;
	Thu,  9 Oct 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028129; cv=none; b=kZSSAxF1eOW7lRzNGhtz1fgp/aoPyzs1mEVWN2RONomjHqFxJMFnonUdm10xBTebwQxU6Pyq4JAqJxmn1pRVlfxjSeufHo7c2a/+1jLfIN95t4op3FBkVt7wYeNYIS2dl6vxNgdl9L1Hw3Mxo1hBxLPSQmwtQZiIMEl5I4TPl30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028129; c=relaxed/simple;
	bh=VhR+zIh3JJEC8n4EYAZalV2WgUgxV3rByiqjevbMEFU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNnHtPsiVw+acRSfrb52PyDW64jW7tvxCngmffZsMJVtuOivnIefri4Lex5P3jwAb3sx2I3OJrZ+ELhd+mlVjapr96MDDyDRL7rf/vhyBQxdtXSASQpnoem877cGmVWstnTzJXs9n4FhFn1L70GguxJcPDwhQ5XPYh0wNl90wLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cjFvg6BF6z6L4sv;
	Fri, 10 Oct 2025 00:39:27 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A69671402EA;
	Fri, 10 Oct 2025 00:42:02 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 9 Oct
 2025 17:42:01 +0100
Date: Thu, 9 Oct 2025 17:42:00 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Marc Zyngier <maz@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Mark
 Rutland" <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, "Saravana
 Kannan" <saravanak@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sven Peter <sven@kernel.org>, Janne Grunau
	<j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark
	<james.clark@linaro.org>
Subject: Re: [PATCH v3 01/26] irqdomain: Add firmware info reporting
 interface
Message-ID: <20251009174200.0000281c@huawei.com>
In-Reply-To: <20250922082833.2038905-2-maz@kernel.org>
References: <20250922082833.2038905-1-maz@kernel.org>
	<20250922082833.2038905-2-maz@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 22 Sep 2025 09:28:08 +0100
Marc Zyngier <maz@kernel.org> wrote:

> Allow an irqdomain callback to report firmware-provided information
> that is otherwise not available in a generic way. This is reported
> using a new data structure (struct irq_fwspec_info).
> 
> This callback is optional and the only information that can be
> reported currently is the affinity of an interrupt. However, the
> containing structure is designed to be extensible, allowing other
> potentially relevant information to be reported in the future.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


