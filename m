Return-Path: <linux-acpi+bounces-5648-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0B18BEC48
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2024 21:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DEE284A31
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2024 19:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A1716E883;
	Tue,  7 May 2024 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYz2M5R2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF3414E2EF;
	Tue,  7 May 2024 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108864; cv=none; b=QFA9syuJNMCdTn2A/dA0YMbgMQXdONUouEvf1/3R0BqnepmSA7FeqTFWwB3z28JeADR0sRppTdvbJQUrQcNg/a+IChVm5z2u7m/FSwl+JVjiBsAuLYFpaKbcfYKyt+wlhyuHopvC/kB+WxccEY5s1QsZ/IaqmPdNHUMojwLF8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108864; c=relaxed/simple;
	bh=TexMWZHQ26C//ctAHxaVIeIDYvtnMtzZSIGXCtmoJns=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzfpWJRvhl68+P8MJifXvyjvkmJx/cdJpYUevv9GbbrRHz4M/RPkWG0dp+pSleciHHxR0mHMyEpCi2zd1gIxI9pOLO0GuBYKwCIh3TAH/QABVIvaOQhB1aP0y8yJfQTgGBPE+zwT088T8xk5AdhBXnVzt6NlDli4GEGLiSXrCe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYz2M5R2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715108862; x=1746644862;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=TexMWZHQ26C//ctAHxaVIeIDYvtnMtzZSIGXCtmoJns=;
  b=WYz2M5R2g2d3t/xWeJfXP9cw408I677/1/KSDYe7azyoH+N3D0FlfKUI
   5RfuePRoRQ2nDzJUJ2aJIZEpBl9Py737msuKkZEuoQ/4Gx2zgJQTm8w2M
   gv2tjiGjD/ZfNkhq7SsHOPrCFvkJrIeWmKbqFEX6uC04z3GeY/Z8+lLhG
   pcDiQcC1DFtC4OA3C4ONHoRf5pts41S7ggxSb9hCoIskxpgmYkKXPt+y4
   nMF9D56W88OjXA8AxH45sYcA4Yh2gswwMam77lBYd9SLK1IRWsP9P6PcD
   lV1sqhwc8eI9xmB4tDn/y6ykWr1MKD3LZJUGMVHw/UMxnb5XIMsXykPCf
   A==;
X-CSE-ConnectionGUID: pSn9ThY5THW5wYz3jvmWJA==
X-CSE-MsgGUID: xmYZpf3ERR6EN70KhOD0MQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11087458"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11087458"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 12:07:42 -0700
X-CSE-ConnectionGUID: 1g+rVmrNSDehNo9hLKvaGw==
X-CSE-MsgGUID: c/eTo/CZRpmFkp6WOhsPrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28682092"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.246.52])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 12:07:40 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [RFC PATCH 1/3] ACPI: extlog: Trace CPER Non-standard Section Body
Date: Tue,  7 May 2024 21:02:20 +0200
Message-ID: <20240507190724.323269-2-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507190724.323269-1-fabio.m.de.francesco@linux.intel.com>
References: <20240507190724.323269-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make extlog_print() (ELOG) trace "Non-standard Section Body" reported by
firmware to the OS via Common Platform Error Record (CPER) (UEFI v2.10
Appendix N 2.3).

This adds further debug information and makes ELOG logs consistent with
ghes_do_proc() (GHES).

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index ca87a0939135..4e62d7235d33 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -182,6 +182,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			if (gdata->error_data_length >= sizeof(*mem))
 				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
 						       (u8)gdata->error_severity);
+		} else {
+			void *err = acpi_hest_get_payload(gdata);
+
+			trace_non_standard_event(sec_type, fru_id, fru_text,
+						 gdata->error_severity, err,
+						 gdata->error_data_length);
 		}
 	}
 
-- 
2.45.0


