Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1E737BD4A
	for <lists+linux-acpi@lfdr.de>; Wed, 12 May 2021 14:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhELMxq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 May 2021 08:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231697AbhELMxD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 May 2021 08:53:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C09A0613CF;
        Wed, 12 May 2021 12:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823907;
        bh=KhhltWu1xUVw2pD4Trd/CN7IzcyIW+WTUTWitSy+z/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxFK1YvocmBh5HfqOl2PyantD5jziIq4z1u02HE3/veBEo5R1TMaL6TTX3ObhGuvq
         PgvjdteH5vS+uRpFFB9o+Lg6/PbIE+NyAuuXXp3uMnnbMhYPIYCuJvX9Cw9ejJpS3v
         02HC+tRQB/Jv5iu1pXo3md4EnHgE3jC+rMp0jPBKoSJ4wcoU8BMPgjGlDtGPHH6yc3
         HjFJ8XWFTwJMmG3Uytkx9AsZErYr4vEliIh7JQJpcDFlK7clPKfptNjuv7YRk5bJcV
         EnI5qyfChfR3ytKG2n+lWDF3GeCOTVPZX5OjTpo6KmloYAuQUXQQ8ncdBV6Mjb2mNi
         Vh0dra9j86S6g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoL3-0018nn-R4; Wed, 12 May 2021 14:51:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 37/40] docs: firmware-guide: acpi: lpit.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:41 +0200
Message-Id: <14b86d84efa6b2c5a7a27e58671e0abcb493cb57.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

So, replace the occurences of the following UTF-8 characters:

	- U+201c ('“'): LEFT DOUBLE QUOTATION MARK
	- U+201d ('”'): RIGHT DOUBLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/firmware-guide/acpi/lpit.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/firmware-guide/acpi/lpit.rst b/Documentation/firmware-guide/acpi/lpit.rst
index 37922a903573..d7d6c406074a 100644
--- a/Documentation/firmware-guide/acpi/lpit.rst
+++ b/Documentation/firmware-guide/acpi/lpit.rst
@@ -5,7 +5,7 @@ Low Power Idle Table (LPIT)
 ===========================
 
 To enumerate platform Low Power Idle states, Intel platforms are using
-“Low Power Idle Table” (LPIT). More details about this table can be
+"Low Power Idle Table" (LPIT). More details about this table can be
 downloaded from:
 https://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
 
-- 
2.30.2

