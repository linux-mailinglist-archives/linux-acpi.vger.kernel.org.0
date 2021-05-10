Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF56378275
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 12:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhEJKft (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 06:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232542AbhEJKey (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 May 2021 06:34:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9239361624;
        Mon, 10 May 2021 10:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642492;
        bh=douQRqdAuSEyY2c01j2A8jGeoYHQIC0zRAigEPzlh3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azusiLCfLPK7/w4iGdDQPjmMGxeoKcFY4r1yfU8sEIwHAeSjI2D4e0nNADeh8l41/
         ea6jTvatCm2sfi9wYZVLyOSYOdlqdsY6kgcLIImKQdYAUS6QSLbW8BGjc0iV1tbPgj
         HCk4ZG/9qaMxpEtUl4oNKeZl55ritr3MCZ5Wnj7Q/kYgu0Iy7BdDfm3f4zthJIT9NH
         fZz6Jn1G1/HpjTKYzBNpbw31cQgUQn2L3cbSt0dxYPeMTDUKksgKhiVB6jLRGY8yG0
         5Ic3lIy5n/gxYB44wwOo3t+6rnfEwA50nVbBM9Yc46EjPDWzlD2gWdlP+IGbfxt1C6
         mr9peKpqfpSvQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38z-000UYO-KN; Mon, 10 May 2021 12:28:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 50/53] docs: firmware-guide: acpi: lpit.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:27:02 +0200
Message-Id: <f981646e5ffb5d6260928041cc3b420f7fb3ad62.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
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

