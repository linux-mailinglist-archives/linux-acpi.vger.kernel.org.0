Return-Path: <linux-acpi+bounces-7979-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D337964DF8
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B339EB218AC
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A140E1B9B43;
	Thu, 29 Aug 2024 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Be6cPNkC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571651B375A;
	Thu, 29 Aug 2024 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957069; cv=none; b=C76xn4rkNmUbY3zFatrSkvXTKV56u68iDl9D3P+P3p2rMn0isqcamqmbE08x7qoEjbKn6gqEBCWesNP/GOu9/7bjYINOw1U86BHo+B2QgGfiQYR/Im5MWsJsean5hapzPRbsojaj4qx6V4CRuQfEm27TfvmIxl50o4YyZGHeLQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957069; c=relaxed/simple;
	bh=qpJqoXXVp81Jqp1u+obwScqa1CLPfjAjajgTXw639pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Owaz9+xJiM8cE8gujB5alryyxA1IvnFnpSD0M12W+b6vuSgae12zMTw0zFhUaRiN8hP0JZ+Wvf+Rf9DVzDjph93v7lfb26ljBXaGgD3tH0gZUHI2tTJQW2Brf44bgbnPnpnYEeJK7vf+Pg1FuYZSNa57M/e5jbpzMu85EKZ9LgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Be6cPNkC reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id cdde2e4b8dfd1e1f; Thu, 29 Aug 2024 20:44:25 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B64BE6A8C15;
	Thu, 29 Aug 2024 20:44:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957065;
	bh=qpJqoXXVp81Jqp1u+obwScqa1CLPfjAjajgTXw639pM=;
	h=From:Subject:Date;
	b=Be6cPNkCq5HiOnpgD0nhy38rlZ3RPVufSr+Lx8VWvSKIVcWC5RVyLLTR4trpscsIH
	 8JfnqftJmTL6mSz9xlbP3tMm6jLrw0RHKZDe3XOX208T0113i41DyFDt4qIMk2cfHR
	 cGtwptaZlfK4iG6E+6/e/MPW7bW1dfrNXlWxmytDVjU7rOg5FRa6znyUHk6QFXOuQ8
	 GV/rR0CA0lURgFK9/rVmkXYd/EA9yHtsiywKtDVQqtSbTXMdt1Z2Kgy77wH4hta24U
	 VGE0NMsJG4WnaEAGknwl+e+BM7YImGxajmrodBRIjWasUHawliqEF5z9cei30TSZZ8
	 KuKe3tMRco5nA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 12/20] ACPICA: Allow for supressing leading zeros when using
 acpi_ex_convert_to_ascii()
Date: Thu, 29 Aug 2024 20:37:31 +0200
Message-ID: <3510303.QJadu78ljV@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeeltdeikeekkeevieektefggfetueetfeejveejgeduledvudehieeuvdeiheeiveenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghkvghtrdguuhhmsghrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Armin Wolf <W_Armin@gmx.de>

ACPICA commit 792a337104ce2c1729d33d76241b42b3214aa60f

Allow to specifiy wether leading zeros should be supressed
ot not when using acpi_ex_convert_to_ascii().

Link: https://github.com/acpica/acpica/commit/792a3371
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/exconvrt.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index 3729bf3b74f7..4e8ab3c26565 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -17,7 +17,8 @@ ACPI_MODULE_NAME("exconvrt")
 
 /* Local prototypes */
 static u32
-acpi_ex_convert_to_ascii(u64 integer, u16 base, u8 *string, u8 max_length);
+acpi_ex_convert_to_ascii(u64 integer,
+			 u16 base, u8 *string, u8 max_length, u8 leading_zeros);
 
 /*******************************************************************************
  *
@@ -249,6 +250,7 @@ acpi_ex_convert_to_buffer(union acpi_operand_object *obj_desc,
  *              base            - ACPI_STRING_DECIMAL or ACPI_STRING_HEX
  *              string          - Where the string is returned
  *              data_width      - Size of data item to be converted, in bytes
+ *              leading_zeros   - Allow leading zeros
  *
  * RETURN:      Actual string length
  *
@@ -257,7 +259,8 @@ acpi_ex_convert_to_buffer(union acpi_operand_object *obj_desc,
  ******************************************************************************/
 
 static u32
-acpi_ex_convert_to_ascii(u64 integer, u16 base, u8 *string, u8 data_width)
+acpi_ex_convert_to_ascii(u64 integer,
+			 u16 base, u8 *string, u8 data_width, u8 leading_zeros)
 {
 	u64 digit;
 	u32 i;
@@ -266,7 +269,7 @@ acpi_ex_convert_to_ascii(u64 integer, u16 base, u8 *string, u8 data_width)
 	u32 hex_length;
 	u32 decimal_length;
 	u32 remainder;
-	u8 supress_zeros;
+	u8 supress_zeros = !leading_zeros;
 
 	ACPI_FUNCTION_ENTRY();
 
@@ -293,7 +296,6 @@ acpi_ex_convert_to_ascii(u64 integer, u16 base, u8 *string, u8 data_width)
 			break;
 		}
 
-		supress_zeros = TRUE;	/* No leading zeros */
 		remainder = 0;
 
 		for (i = decimal_length; i > 0; i--) {
@@ -379,6 +381,7 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 	u32 string_length = 0;
 	u16 base = 16;
 	u8 separator = ',';
+	u8 leading_zeros;
 
 	ACPI_FUNCTION_TRACE_PTR(ex_convert_to_string, obj_desc);
 
@@ -400,6 +403,7 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 			 * Make room for the maximum decimal number size
 			 */
 			string_length = ACPI_MAX_DECIMAL_DIGITS;
+			leading_zeros = FALSE;
 			base = 10;
 			break;
 
@@ -408,6 +412,7 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 			/* Two hex string characters for each integer byte */
 
 			string_length = ACPI_MUL_2(acpi_gbl_integer_byte_width);
+			leading_zeros = TRUE;
 			break;
 		}
 
@@ -428,7 +433,8 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 		string_length =
 		    acpi_ex_convert_to_ascii(obj_desc->integer.value, base,
 					     new_buf,
-					     acpi_gbl_integer_byte_width);
+					     acpi_gbl_integer_byte_width,
+					     leading_zeros);
 
 		/* Null terminate at the correct place */
 
@@ -448,6 +454,7 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 			 * From ACPI: "If the input is a buffer, it is converted to a
 			 * a string of decimal values separated by commas."
 			 */
+			leading_zeros = FALSE;
 			base = 10;
 
 			/*
@@ -475,6 +482,7 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 			 *
 			 * Each hex number is prefixed with 0x (11/2018)
 			 */
+			leading_zeros = TRUE;
 			separator = ' ';
 			string_length = (obj_desc->buffer.length * 5);
 			break;
@@ -488,6 +496,7 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 			 *
 			 * Each hex number is prefixed with 0x (11/2018)
 			 */
+			leading_zeros = TRUE;
 			separator = ',';
 			string_length = (obj_desc->buffer.length * 5);
 			break;
@@ -528,7 +537,8 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 
 			new_buf += acpi_ex_convert_to_ascii((u64) obj_desc->
 							    buffer.pointer[i],
-							    base, new_buf, 1);
+							    base, new_buf, 1,
+							    leading_zeros);
 
 			/* Each digit is separated by either a comma or space */
 
-- 
2.43.0





