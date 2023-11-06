Return-Path: <linux-acpi+bounces-1292-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F937E2FE0
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 23:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C9A1C204F6
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 22:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3BC2E3F3
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 22:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kmj/zlsY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18E22EAE2
	for <linux-acpi@vger.kernel.org>; Mon,  6 Nov 2023 22:00:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD8E11F;
	Mon,  6 Nov 2023 14:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699308042; x=1730844042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vszWPPXsju9JscN66VI8Yo3KG0OPHwEoAvA9/gUL2jU=;
  b=Kmj/zlsYRdv8Wg1N+SX7OR//+Nx8rogG5zxkhDhUuq1K186mRt1F6e+y
   wDmt7s0pxU7D0KBJI6Ce9zFd7UfaoITRBvn2aaKLV2rdrULn/8rM79D6m
   8iqZag3QIWOL3mz5oTPASuDD2zQEutnSIxOpgrMugvzuSjpzrwnrNfNho
   1ASZhzmb/UfPrwQkUO8g7agemd0UxaZN3m17U+i92wnSjXYWbfEFWLaug
   F1OaxVW9p6TqZ0HqfcAp7feRTvFKaMcPzAFwZpclz5EW2QCSrDUUSIJbc
   az39zQKRc+BUkXMOr6n/Z9Io0QsssmZpYaLi+qJN9og5IZFaVf7dcr6RI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475614938"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="475614938"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 14:00:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="712335738"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="712335738"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 14:00:40 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id A5CD211F894;
	Mon,  6 Nov 2023 23:50:49 +0200 (EET)
Date: Mon, 6 Nov 2023 21:50:49 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/7] ACPI: scan: Extract MIPI DisCo for Imaging data
 into swnodes
Message-ID: <ZUlfuWB9z1tlOGG7@kekkonen.localdomain>
References: <4542595.LvFx2qVVIh@kreacher>
 <1987710.usQuhbGJ8B@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1987710.usQuhbGJ8B@kreacher>

Hi Rafael,

On Mon, Nov 06, 2023 at 05:27:26PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] ACPI: scan: Extract MIPI DisCo for Imaging data into swnodes
> 
> Add information extracted from the MIPI DisCo for Imaging device
> properties to software nodes created during the CSI-2 connection graph
> discovery.
> 
> Link: https://www.mipi.org/specifications/mipi-disco-imaging
> Co-developed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3:
>    * Change the name of the new file to mipi-disco-img.c
>    * "DiSco" -> "DisCo" in multiple places
>    * Fix the link in the Link: tag
>    * Change the number of data lanes limit and add a comment regarding it
>    * Use ACPI_DEVICE_CSI2_DATA_LANES directly in several places instead
>      of array sizes equal to it

Thanks for the update. I've tested the set, so you can add:

Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>

with the following diff fixing mipi-img-lane-polarities parsing:

diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
index 3123180d9b54..92b45e792a07 100644
--- a/drivers/acpi/mipi-disco-img.c
+++ b/drivers/acpi/mipi-disco-img.c
@@ -530,7 +530,12 @@ static void init_csi2_port(struct acpi_device *adev,
 	}
 
 	ret = fwnode_property_count_u8(port_fwnode, "mipi-img-lane-polarities");
-	if (ret * BITS_PER_TYPE(u8) >= num_lanes + 1) {
+	if (ret < 0) {
+		acpi_handle_debug(handle, "Lane polarity bytes missing\n");
+	} else if (ret * BITS_PER_TYPE(u8) < num_lanes + 1) {
+		acpi_handle_info(handle, "Too few lane polarity bytes (%lu vs. %d)\n",
+				 ret * BITS_PER_TYPE(u8), num_lanes + 1);
+	} else {
 		unsigned long mask = 0;
 		int byte_count = ret;
 		unsigned int i;
@@ -543,15 +548,15 @@ static void init_csi2_port(struct acpi_device *adev,
 		 */
 		BUILD_BUG_ON(BITS_PER_TYPE(unsigned long) <= ACPI_DEVICE_CSI2_DATA_LANES);
 
-		if (byte_count > ACPI_DEVICE_CSI2_DATA_LANES) {
+		if (byte_count > sizeof(mask)) {
 			acpi_handle_info(handle, "Too many lane polarities: %d\n",
 					 byte_count);
-			byte_count = ACPI_DEVICE_CSI2_DATA_LANES;
+			byte_count = sizeof(mask);
 		}
 		fwnode_property_read_u8_array(port_fwnode, "mipi-img-lane-polarities",
 					      val, byte_count);
 
-		for (i = 0; BITS_PER_TYPE(u8) * i <= num_lanes; i++)
+		for (i = 0; i < byte_count; i++)
 			mask |= (unsigned long)val[i] << BITS_PER_TYPE(u8) * i;
 
 		for (i = 0; i <= num_lanes; i++)
@@ -561,8 +566,6 @@ static void init_csi2_port(struct acpi_device *adev,
 				PROPERTY_ENTRY_U32_ARRAY_LEN("lane-polarities",
 							     port->lane_polarities,
 							     num_lanes + 1);
-	} else {
-		acpi_handle_info(handle, "Lane polarity bytes missing\n");
 	}
 
 	swnodes->nodes[ACPI_DEVICE_SWNODE_EP(port_index)] =

-- 
Kind regards,

Sakari Ailus

