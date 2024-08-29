Return-Path: <linux-acpi+bounces-7976-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8896964DF0
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFA11C2308B
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB401B8E93;
	Thu, 29 Aug 2024 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="jVi6pACt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8561B7913;
	Thu, 29 Aug 2024 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957068; cv=none; b=sBG/DihXF6FVJtb5eS/6RMszGsj08Desnt6tyNLEjGgmQI1Qs7BIvKwmUAsH+bMKOPdA/e6YsNlaR4/DD5jdiO2LD54pnxAKWhiqtNIk98/2SxrDzpeOscgxPSCT96uekLYvzrWkf0a+6VRRlrZOB9R16njZFsLzRkK4ZScSpvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957068; c=relaxed/simple;
	bh=mIy9JxvhRIRvLzO+6BkJm+Q6Vl9WccDSq/P3Lw03wgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/PGiA8zrHDmRTsDTx9E5CJIvmqUG3H6duAws4LZGN7Fcf5UkMe5amn4VxNYGLP7sfPCRE5NtcvKrdczdqy9k2V4FzNsDluzaO+NMarPs4jCA3DxtSyxtgtjx6F7yFugrzYlgNQHM9f5KVDZLCN5rgsFy5lMCcbO5k6fmh26y8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=jVi6pACt; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id e9c951e4dd3a5a6d; Thu, 29 Aug 2024 20:44:23 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 972706A8C15;
	Thu, 29 Aug 2024 20:44:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957063;
	bh=mIy9JxvhRIRvLzO+6BkJm+Q6Vl9WccDSq/P3Lw03wgI=;
	h=From:Subject:Date;
	b=jVi6pACttOrlpM1ujtVt+DTS4KO9ojmHPdn01wdrw7mVqxl+vkCdHqZoLDFpIMrTE
	 jox2w7uCLujGpAXhs8yR0TdY1qPw2ldhNNFbFWdwp0gDFpBwGXxu1r8gxmMbaeUNO5
	 OhZ6immaBCF0zVR/vgM3szR2Azwr5vNuoDH2QJNxwS3x/cpKQ2nF6R9alIIWpHKKvX
	 KYNiwuSXCev5zSOO3AQUtL75kVryuc+zmRhA9PznJBIxqDhEVYLcgQ/LsxjxvS7dDb
	 TOAXo0s75DrsnM2xHGjkO7/dfmefgliVBKvOCjfCd2Xr/dm56c6Y363/nBrmhM5q28
	 gZwen6hvcGiQQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 14/20] ACPICA: Update integer-to-hex-string conversions
Date: Thu, 29 Aug 2024 20:39:15 +0200
Message-ID: <4378385.ejJDZkT8p0@rjwysocki.net>
In-Reply-To: <5819337.DvuYhMxLoT@rjwysocki.net>
References: <5819337.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeeltdeikeekkeevieektefggfetueetfeejveejgeduledvudehieeuvdeiheeiveenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghkvghtrdguuhhmsghrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Armin Wolf <W_Armin@gmx.de>

ACPICA commit f2cb44f6deb6325a6b348b225fc82f565a870899

Add "0x" prefix for explicitly converted integers
and suppress leading zeros in such a case.
Provides compatibility with other ACPI implementations.

Link: https://github.com/acpica/acpica/commit/f2cb44f6
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/exconvrt.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index 9647325d290d..bb1be42daee1 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -417,6 +417,16 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 			base = 10;
 			break;
 
+		case ACPI_EXPLICIT_CONVERT_HEX:
+			/*
+			 * From to_hex_string.
+			 *
+			 * Supress leading zeros and append "0x"
+			 */
+			string_length =
+			    ACPI_MUL_2(acpi_gbl_integer_byte_width) + 2;
+			leading_zeros = FALSE;
+			break;
 		default:
 
 			/* Two hex string characters for each integer byte */
@@ -437,6 +447,13 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 		}
 
 		new_buf = return_desc->buffer.pointer;
+		if (type == ACPI_EXPLICIT_CONVERT_HEX) {
+
+			/* Append "0x" prefix for explicit hex conversion */
+
+			*new_buf++ = '0';
+			*new_buf++ = 'x';
+		}
 
 		/* Convert integer to string */
 
@@ -449,6 +466,13 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 		/* Null terminate at the correct place */
 
 		return_desc->string.length = string_length;
+		if (type == ACPI_EXPLICIT_CONVERT_HEX) {
+
+			/* Take "0x" prefix into account */
+
+			return_desc->string.length += 2;
+		}
+
 		new_buf[string_length] = 0;
 		break;
 
-- 
2.43.0





