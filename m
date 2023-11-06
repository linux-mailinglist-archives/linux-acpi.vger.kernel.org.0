Return-Path: <linux-acpi+bounces-1247-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EED57E1C38
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 09:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5852810F4
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 08:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5904154B7
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WD09d0ma"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EB98F54;
	Mon,  6 Nov 2023 07:06:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC0FC6;
	Sun,  5 Nov 2023 23:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699254378; x=1730790378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=G9ErlH/+M/Rbhu99aimM6BxS7FI2wLaofzX009O7Z7A=;
  b=WD09d0maJobWJ55CNTzidDuyJqKJxSsA/qD1+vWRYxEAnd/pFFHfyZd1
   MIJWZX3JlS+KRYT615erLp9QG/6uZ/aTuv47rIi3xy3qs9SUsCuBAneBY
   0ssueZRLAt83Utjw7S0lBQ2sgxTCV5pVjvg3pRIroWsTpwIh5GjVuEZCX
   S1Xiyor/24SP6LGzF6fPX0GB14ykK4Qm/O3W5wc1cgq0M3SxJyXuJJtfU
   Uyd2Sv43behrLG1/UjcxuQgv6CDb9AhZWVlcGJ1bDNbSVhVwajbgnaLu3
   pc12bUZgPz4si44x2u4yGG2SlDrtfGPfvgbZy59EFG5pXjQDCTqzMRm0l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="420334506"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="420334506"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 23:06:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="828122027"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="828122027"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 23:06:14 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 7DCEC11F724;
	Mon,  6 Nov 2023 09:06:11 +0200 (EET)
Date: Mon, 6 Nov 2023 07:06:11 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-media@vger.kernel.org,
	Paul Elder <paul.elder@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Julien Stephan <jstephan@baylibre.com>, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/1] device property: Add fwnode_name_eq()
Message-ID: <ZUiQY9s0DKmkbzAR@kekkonen.localdomain>
References: <20231102081611.1179964-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0h5q__nbfxLUN-cZDSvjTCJHSZwoDEz_cq+bUJGSn1u-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h5q__nbfxLUN-cZDSvjTCJHSZwoDEz_cq+bUJGSn1u-A@mail.gmail.com>

Hi Rafael,

On Fri, Nov 03, 2023 at 03:48:23PM +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 2, 2023 at 9:22 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Add fwnode_name_eq() to implement the functionality of of_node_name_eq()
> > on fwnode property API. The same convention of ending the comparison at
> > '@' (besides NUL) is applied on also both ACPI and swnode. The function
> > is intended for comparing unit address-less node names on DT and firmware
> > or swnodes compliant with DT bindings.
> >
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > Hi Rafael,
> >
> > Could we merge this via the media tree (pending further review comments,
> > if any)?
> 
> This would be fine with me, so please feel free to add
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Thanks!

> 
> to this patch (when ready), but you need to ask Greg about it, because
> he's been handling device properties changes lately.

I must have missed this somehow... I'll resend v4.

-- 
Regards,

Sakari Ailus

