Return-Path: <linux-acpi+bounces-19424-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B231DCA3B2A
	for <lists+linux-acpi@lfdr.de>; Thu, 04 Dec 2025 14:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B365D3036E1D
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Dec 2025 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C738341AB6;
	Thu,  4 Dec 2025 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipearl.com header.i=@sipearl.com header.b="cVOKkp+u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout.sipearl.com (smtpout.sipearl.com [178.170.11.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FA296BDB;
	Thu,  4 Dec 2025 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.170.11.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764853281; cv=none; b=Cn3/nAbh0o+S2WJ8QLgH7z5SizqjqMSupOEDULRsUhhmh5s9iMTxjUNmNrOEFFWmDLqCinrPzg6VWkpU1HWNMvQa9anbulFoF/jnTL8iGnQFLTJ6AQH4Ih6H9VsW6weiNfDCw7Tv8B5umzw6T8biXbtxqtxx6A2PR1S3krTClWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764853281; c=relaxed/simple;
	bh=CF9gyM8B15HnPxWwvuWug7hV2IYVEinzxWbNzLaiRZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqLzRcm3F/UB/7i4OFySX56brnOsd7r/lflaUskKwd15TEjp5k4SYUMJHwDC21r5cW1TmpXvaKjv+chQTjIy9029ByOxjnmSFO9ARlZGyn0gpMufDce1lagCqb7AKSCm/Gfiwj11ER4pnqP/V6FO62PtPOYSJX5YmcRNXTULzmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipearl.com; spf=pass smtp.mailfrom=sipearl.com; dkim=pass (2048-bit key) header.d=sipearl.com header.i=@sipearl.com header.b=cVOKkp+u; arc=none smtp.client-ip=178.170.11.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipearl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipearl.com
Received: from smtpout.sipearl.com ([172.31.29.1])
	by smtpin.sipearl.com  with ESMTPS id 5B4D0hc5016603-5B4D0hc7016603
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 14:00:43 +0100
Received: from dc2pvlnosz001.pub.int.sipearl.com (172.31.65.18) by
 dc2pvwexcz001.sipearl.corp (172.31.29.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Thu, 4 Dec 2025 14:00:43 +0100
From: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
To: <sudeep.holla@arm.com>
CC: <andrea.tomassetti@sipearl.com>, <jassisinghbrar@gmail.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lkp@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, <olivier.dautricourt@sipearl.com>,
	<olivierdautricourt@gmail.com>, <rafael@kernel.org>,
	<thibault.cantori@sipearl.com>
Subject: Re: Re: [PATCH v3 1/2] mailbox: pcc: support polling mode when there is no platform IRQ
Date: Thu, 4 Dec 2025 13:59:38 +0100
Message-ID: <20251204125938.3025022-1-andrea.tomassetti@sipearl.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251203-persimmon-condor-of-essence-9fc43d@sudeepholla>
References: <20251203-persimmon-condor-of-essence-9fc43d@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dc2pvwexcz001.sipearl.corp (172.31.29.1) To
 dc2pvwexcz001.sipearl.corp (172.31.29.1)
X-FEAS-Client-IP: 172.31.29.1
X-FE-Policy-ID: 2:2:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=sipearl.com; s=sipearl2024; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=jkRGH+WC/Hs6lKqWmqDZ/0XMwhjbFXbvZN3peUEPMaE=;
 b=cVOKkp+u8dJ3rCn7MA/Dr/B69Lp4bPxBIRy2SiNnNyhtEl3882+lm4a7j11ISS0/RM4lduYS/cw3
	LYWWdbX7D/QulpLBaQOt4BhB0xdL6lX9NldkNx5neaCxqFwoDPGvqQiN+POORFvyrpCWWpoCUjhw
	c5HTjHWfvCJuO/HAzVhlSTC/d2dA6YkCq/6qISWgkYFcEaKttzVkmoUYP2nGrEtzslIhbtFVFIKD
	4FiL2WNg1icPfeXWvoi9k3HSO/937jP927XUMOs1rfinhnGkUy0N7DGdcStwtRfoLUp0CXbPpvE+
	JKQG7UWssDePpJ/nIO2NO1iri1cP+XTd9r7dkg==

On 25/12/03 10:28AM, Sudeep Holla wrote:
> On Tue, Dec 02, 2025 at 11:12:14AM +0100, Andrea Tomassetti wrote:
> > The goal is to allow clients to submit a message in both irq and polling
> > mode of the pcc mailbox. The ACPI specification does not require a
> > platform irq for pcc channels. Let's implement the case where it is not
> > available.
> >
> 
> Just curious if you have a real use case for this polling mode on your
> platforms or ...
> 
> > Tested-by: Thibault Cantori <thibault.cantori@sipearl.com>
> > Co-developed-by: Olivier Dautricourt <olivier.dautricourt@sipearl.com>
> > Signed-off-by: Olivier Dautricourt <olivier.dautricourt@sipearl.com>
> > Signed-off-by: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202511120243.soxAFpqQ-lkp@intel.com/
> > Closes: https://lore.kernel.org/oe-kbuild-all/202511120558.Cln7LF6M-lkp@intel.com/
> > Closes: https://lore.kernel.org/oe-kbuild-all/202511120729.R3XQNSnx-lkp@intel.com/
> 
> You are just trying to fix these warnings. If it is latter, we don't have to
> add support for polling mode especially if it can't be tested on real
> platforms.
>
In our target product, we're still investigating if PCC-based SCMI communication will
rely on interrupts or polling. When we started looking into it we realized that polling
wasn't supported and that's why we decided to work on and send this patch. We thought it
could have been beneficial to other members of the community and it brings the driver a
bit closer to the ACPI specifications.

We're using ARM Fast Models for prototyping and that's how we validated and tested this patch.

Best regards,
Andrea
> -- 
> Regards,
> Sudeep

