Return-Path: <linux-acpi+bounces-19630-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C2ACC7D7D
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 14:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F19330088DA
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726E53659E3;
	Wed, 17 Dec 2025 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8AOp38O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3366E3659E7;
	Wed, 17 Dec 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765978393; cv=none; b=oRLWzuyAPeO4YTLvYCw0Mw6kkdaKv+4teN188ctW+vn3xrtuOHs02MreLZ6daw3hQAfKH5z4yJdhwlzlDQS/DP1VUZGfFvVtDZeaLHSICaHs/XcZXMHjDAzmBPkcZMn9qhRojuAE069ghMwIYjD2nE1DZvfRfyycslGk+szDBBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765978393; c=relaxed/simple;
	bh=Yyr00ybjlGb3vpYCKCf6NwSV/rqYFelDrGQq8LmdiXs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=axpMVoZe6wbF0Unv8eMl3b4SWXlSxK8UBUFt2vlSbHZ06YsMqwAS542dIm1gwF3a6PqvdUywdOOE9vlYe+ouFpx6scxv204cxWWSFROBRqfMiKGQ7l4Tipe1NYPj7kjyCHbG2SGWcIMXHctTnVz/pYRTxz2vCtuXM2e/rnKYIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8AOp38O; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765978392; x=1797514392;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Yyr00ybjlGb3vpYCKCf6NwSV/rqYFelDrGQq8LmdiXs=;
  b=V8AOp38ONhhHArhI1O4pNP8u/V057eXA91Z8khzMKRQSH2YBYXNsjEuX
   58Wvo9KIEsKrgUMDQoUmnNTSUxb3l7HCKq/oY4EgB6YJZDDya0I1d7FiT
   nxQtpdjbjc4WUdMAWFpvyIFupaJNogdQloiyd1pvzjg9EJDVsAYxVCUXu
   UEcGAhCqQ75p2KNQQaMZ+98PSYgXMIMUetL44Rekxrq6MenrKdCp5I3C1
   p+KO3h763DZFUHbxfllzhg8T6ZCFi8ARS7U+l9D4kHyhmploGTYGwlcUH
   raDXsYafWxCu2iyq4WBsWdz+iML7URlx/OhWeHxVSO3EHQ6dUTX1zwb5Z
   w==;
X-CSE-ConnectionGUID: lXEaqCYKRcmqdThrgvqmvw==
X-CSE-MsgGUID: gmuM0sr3TZyk7Nk0t8NNTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67854151"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67854151"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 05:33:11 -0800
X-CSE-ConnectionGUID: Zs0KPE4xTWOdUI4QXKZQqw==
X-CSE-MsgGUID: VizgtfPNQLyKH/0iqY5sQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="199113593"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.124.223.122]) ([10.124.223.122])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 05:33:09 -0800
Message-ID: <250bec4336d5e7adbc841e4945e50e589b10c375.camel@linux.intel.com>
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: kernel-team@lists.ubuntu.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, 	linux-pm@vger.kernel.org,
 mmikowski@kfocus.org, rjw@rjwysocki.net
Date: Wed, 17 Dec 2025 05:33:08 -0800
In-Reply-To: <20251215092525.6ea95739@kf-m2g5>
References: <20251214184507.21f95134@kf-m2g5>
		<33fc5ba96b80f1eeb69777822cfddefe64100540.camel@linux.intel.com>
	 <20251215092525.6ea95739@kf-m2g5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Aaron,

Tested on a platform with the similar CPU (100 MHz more max). There is
no issue in max frequency or base frequency display.

I suggest to check with Clevo.

I will also try to reach out.

Thanks,
Srinivas

On Mon, 2025-12-15 at 09:25 -0600, Aaron Rainbolt wrote:
> On Mon, 15 Dec 2025 06:16:10 -0800
> srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>=20
> > This data is not consistent with the reported frequencies M-TEST
> > frequencies.
> > I need to get hold of such internal system with the same processor
> > and
> > check what is reported.
>=20
> Thank you Srinivas! Please let me know if you need anything else
> from here.
>=20
> --
> Aaron

