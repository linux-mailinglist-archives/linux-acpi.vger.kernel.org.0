Return-Path: <linux-acpi+bounces-19689-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5377ECCF01A
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 09:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE2B23011ED5
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 08:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0EB2E4257;
	Fri, 19 Dec 2025 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7SMNvZJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6132D59FA;
	Fri, 19 Dec 2025 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766133413; cv=none; b=Rla4rgYaRDbOtbPmI7bo2LVuJw7PM/pPhEYQKqJCXL7KCL5VSxZlQETTt2xfXivZjHZKKowInB63RpApdSW/K2OQlK5WY+PyofG2zdJutKqPvxRc1pxlROV3QFY8gmahhJOf+OaRasFp3ppShRCd9+8PbLIPfyK0WOe0sGazXlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766133413; c=relaxed/simple;
	bh=WXn23T9sGToA2inqUvjPMcLHnPkO2FzBNAxr8c+QgCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fm/+NTwhVwmBg//s11a6xu1cNda6mwgFiUP8a8KkQ05AJDEFEFeus3Nm1Tdyzaz46LXowCLpmUzXPdnW//qjsjg6DUxdA+B1zY0WoIsXnVqMLj7nAtw3smkVrY0Go3D484PFDOz+od6Nl+QF6uZML/7eIMIBQgP7lcNm62/rvic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e7SMNvZJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766133411; x=1797669411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WXn23T9sGToA2inqUvjPMcLHnPkO2FzBNAxr8c+QgCo=;
  b=e7SMNvZJNF8bdFUWC/RVlwsPJLvZssWTKizRVHTLYBZPepzj1M6wdAyt
   NMIUJ8MO+Ocz1m4/TEus6MlS7wB+9UHAhGAlUuIoJzUKH9UZkg0Y+SJSZ
   B4kxn1iviICKYGQKnBdawEC9LK7POeK40U28NDNC9EOqc67o6C2Mb6elh
   lkXR1Tq+pYXiZspfCzsTelr1Qurja8UAtN5eSnRgggqKjSuvjyhR/Qkxz
   Upw1PQLTMwjQdP/daVd7M5ECDNEJC/c+srcToJk31CBaz1lU7JEBNRGHp
   8JHfWnvnTF01ZAy3AFsZU0wYja3efqwi4cCLssO8WC3VVdJg5+aiv0dHi
   Q==;
X-CSE-ConnectionGUID: IkOXfitzSEWEb5tmSlKq0A==
X-CSE-MsgGUID: cvUEsie0QJGrf24UkhW0tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="70663224"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="70663224"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 00:36:51 -0800
X-CSE-ConnectionGUID: zKvpe6o5TYyu7tqYDWalyA==
X-CSE-MsgGUID: 2UtasM+CQgCPipM8WzKDEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="198715074"
Received: from rvuia-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.226])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 00:36:48 -0800
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 4F50F120EC2;
	Fri, 19 Dec 2025 10:36:47 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1vWVyY-0000000AIR4-3cno;
	Fri, 19 Dec 2025 10:36:38 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	linux-acpi@vger.kernel.org,
	Kenneth Crudup <kenny@panix.com>,
	linux-media@vger.kernel.org,
	johannes.goede@oss.qualcomm.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/1] software node: Also support referencing non-constant software nodes
Date: Fri, 19 Dec 2025 10:36:38 +0200
Message-ID: <20251219083638.2454138-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <af773b82-bef2-4209-baaf-526d4661b7fc@panix.com>
References: <af773b82-bef2-4209-baaf-526d4661b7fc@panix.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fwnode references are be implemented differently if referenced node is a
software node. _Generic() is used to differentiate between the two cases
but only const software nodes were present in the selection. Also add
non-const software nodes.

Reported-by: Kenneth Crudup <kenny@panix.com>
Closes: https://lore.kernel.org/all/af773b82-bef2-4209-baaf-526d4661b7fc@panix.com/
Fixes: d7cdbbc93c56 ("software node: allow referencing firmware nodes")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
Hi Kenneth,

Many thanks for reporting the issue and bisecting the offending patch!
Could you confirm whether this fixes the issue (it does for me)?

- Sakari

 include/linux/property.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 272bfbdea7bf..e30ef23a9af3 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -371,6 +371,7 @@ struct software_node_ref_args {
 (const struct software_node_ref_args) {				\
 	.swnode = _Generic(_ref_,				\
 			   const struct software_node *: _ref_,	\
+			   struct software_node *: _ref_,	\
 			   default: NULL),			\
 	.fwnode = _Generic(_ref_,				\
 			   struct fwnode_handle *: _ref_,	\
-- 
2.47.3


