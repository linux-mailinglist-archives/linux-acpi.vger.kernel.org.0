Return-Path: <linux-acpi+bounces-11459-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF32A441EF
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 15:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E02D7A4A42
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32A62686B3;
	Tue, 25 Feb 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="ZCEln7GL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04744267AF1;
	Tue, 25 Feb 2025 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492626; cv=pass; b=oKw3Xs3RbnM2+dyD0jcIQgle0ayrP9HiLCOMeLGD5cR+BjEcH1uWHpCcvkhBAen3UoQzxS2+gYLHp+WPAHeXSYR4ChVKyk+Ev4OPAnikM7OCMDQvuve8O4Q6mwb9z/+AFEF3aV/U8/zw17suGoZrSLyp0TcrHgkT2AsB6H3Zweg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492626; c=relaxed/simple;
	bh=J4exwO/+LQyAJyRNIrMNLTbcedqtgXIJl167NDlKJSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KB7uNjjyT9gc66YlpTfBmow2+xcRvOXZCfJrT1ZipW5CVY7h9yxd1aJEedUtcL2wq66zCnq7JDmTCfFkloCp2M3c/iJi9ux/TJ5whTgMeaSRYM5FeGJYflwO0evZyCW6ayZKduZ18ygMtgguM0C5PoILh15CezLil5bpvpsQB6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=ZCEln7GL; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1740492597; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hIKFGiT9t3XLBwc8oRJ+23gQYIC+p+v6EkmQuj1Z1AIlP62FNp5XpdcE0Aj4T2LnJ/XCgAgAUz+HmWZVQlrvtdyZG77iaX/SKJj0/N1moFGWGgFhoABATSq/RxW8AAwQifvg6fDmMSGVSVwNf0SdBJ1RUQ76CRAszobq5qBdGwI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740492597; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=J4exwO/+LQyAJyRNIrMNLTbcedqtgXIJl167NDlKJSw=; 
	b=iXmhx0yz0B95IiKjM6GVB9dd/uUpPczaXiW+YDs1QU2allXq8mCuXgWKumpW3DFJmDUiyUIsgJJ9614OUQDNscPGBTgbE6gM4tPEGyBW9H4GnlN+sbNqchWlWRKYnDRPgsS+mY9xq+QTR01dOXvQ+Jv6bw7BWK+yzuaciC0MdYA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740492597;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=J4exwO/+LQyAJyRNIrMNLTbcedqtgXIJl167NDlKJSw=;
	b=ZCEln7GLGctlmlw/aORR5iOe7TliNdBslwHHBA3fnSmm19acasR0x4ys18KznNKw
	ixLDgw9tp7KE/o7xPW4y6MKcfZakSr9/dfEK4vGyLtkA0e+rWAd0Uqddt2/LO1vtrmy
	l0ohehFPqoamc4F9Mdc2BJ3/4arrcmWk27bGwPa8=
Received: by mx.zohomail.com with SMTPS id 174049259425046.988725414291935;
	Tue, 25 Feb 2025 06:09:54 -0800 (PST)
Message-ID: <136183d2-0288-4647-b504-1a75d58e627a@zohomail.com>
Date: Tue, 25 Feb 2025 22:09:48 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] acpi: numa: Add support to enumerate and store
 extended linear address mode
To: Dave Jiang <dave.jiang@intel.com>
Cc: rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
 tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20250224182202.1683380-1-dave.jiang@intel.com>
 <20250224182202.1683380-2-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250224182202.1683380-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122755fa05c750eeb57b0278a126000043aa92fba78fac3ce8bd97035fe0ca32fd1950e4e88ab10b2c:zu0801122740c2803025139f1138bdf59b00002f67723514aef9b7e23c0ab8d128e7349bb333c8fca8c44039:rf0801122d4598f2cf8575ae96fd1a70b8000001634e644520c409f81930d9482988e20c03f1668add021fa51f767db81284:ZohoMail
X-ZohoMailClient: External

On 2/25/2025 2:20 AM, Dave Jiang wrote:
> Store the address mode as part of the cache attriutes. Export the mode
> attribute to sysfs as all other cache attributes.
>
> Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

