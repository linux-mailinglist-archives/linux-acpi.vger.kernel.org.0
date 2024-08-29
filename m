Return-Path: <linux-acpi+bounces-7970-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F061E964B9E
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0561F214B2
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAB31B143B;
	Thu, 29 Aug 2024 16:24:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19551B0117;
	Thu, 29 Aug 2024 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948689; cv=none; b=lI4dkRsnaO1zJjzt1r8Zs2GInkgwjuIk0G5IA0S4mJQVGql9L3KOMU0ZN8evJDBxLdsTdMPMMIsNdAhdcz96L7G/T5QmCILX26g/psgkqUvawaYJ4fyUNwJMAeMhLbLt2lak4coZ/4/RdBuocAZoT6lFT34eF6oxKqoIJ++b0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948689; c=relaxed/simple;
	bh=8xb0icPtltMAc+V6b/uJsv3r2//xNmKDMQYZoNJARcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz857mHUuI+2iXhYwtbDrSCwDIZfB+ED2xfatSxZzJFjxfunWVvB1RLslC7BqI4XZPah4yPyXOtHl6r+VB30X9sidq/qGDu3+oJtbeTPo7AS29ajdqYHuW//Auhk8/1U67PxbtHTiOj7LMlxmoZF2jMzR0sUQ9pFUMbxUP/6uE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30F81106F;
	Thu, 29 Aug 2024 09:25:13 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 387293F762;
	Thu, 29 Aug 2024 09:24:45 -0700 (PDT)
Date: Thu, 29 Aug 2024 17:24:42 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Fu Wei <fu.wei@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	<linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] acpi/arm64: Adjust error handling procedure in
 gtdt_parse_timer_block()
Message-ID: <ZtCgyuQ4IRr9Mx8x@bogus>
References: <20240827101239.22020-1-amishin@t-argos.ru>
 <ZtCfKEIfJW7X8UWg@bogus>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtCfKEIfJW7X8UWg@bogus>

On Thu, Aug 29, 2024 at 05:17:44PM +0100, Sudeep Holla wrote:
> On Tue, Aug 27, 2024 at 01:12:39PM +0300, Aleksandr Mishin wrote:
> > In case of error in gtdt_parse_timer_block() invalid 'gtdt_frame'
> > will be used in 'do {} while (i-- >= 0 && gtdt_frame--);' statement block
> > because do{} block will be executed even if 'i == 0'.
> > 
> > Adjust error handling procedure by replacing 'i-- >= 0' with 'i-- > 0'.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> 
> (For some reason I don't see the original email in my inbox, might have
> got blocked 🙁). Anyways LGTM,
> 
> Acked-by: Aleksandr Mishin <amishin@t-argos.ru>

Sorry I messed up, I meant

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

