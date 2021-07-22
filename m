Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F203D2136
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jul 2021 11:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhGVJJl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jul 2021 05:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231367AbhGVJJk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Jul 2021 05:09:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD8E561249;
        Thu, 22 Jul 2021 09:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626947415;
        bh=eMN4trP2Cpv3GPLMjJE9QNeboZ9xeGzJAQ+eNz9pvFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HHdpB9cpF6pm9//SfavJJ/eW05mwK9WOfjQMps/oY2lMsP7Uyj3P7N4KTXW8Z0A8W
         Tz8JK0/ac2mZo+/79F0JCrULcXCGwnHwPpjJ1EHdZdsABi0S5tEGSaXuedKT3AmA1H
         fYvpq8KoNVYWRs4F2EiDJSKzOFn/9BO5j+Edh7eX3+fCYKZsO3b//h5IX61N3pkw75
         aPVfQLvbCTQoLIHMsQvVSeyCRcJIrYlrB6IV8YdLNWqI3sBXS0GLfDCtQ3cm/gpeW5
         qXxBjiBZcAXtylw+4VHigsmuAnFPV4+4TZA4y57MPN1k5M3I60xiYP+S9lmdwMTGMs
         WetlG/eCT+iZA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6VLD-008lGk-Ds; Thu, 22 Jul 2021 11:50:07 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 2/3] docs: firmware-guide: acpi: dsd: graph.rst: replace some characters
Date:   Thu, 22 Jul 2021 11:50:02 +0200
Message-Id: <a65b04a5cf341cff02d4b514dd4889b4fa4f94b8.1626947264.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626947264.git.mchehab+huawei@kernel.org>
References: <cover.1626947264.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
conversion and some cut-and-pasted text contain some characters that
aren't easily reachable on standard keyboards and/or could cause
troubles when parsed by the documentation build system.

Replace the occurences of the following characters:

	- U+00a0 (' '): NO-BREAK SPACE
	  as it can cause lines being truncated on PDF output

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/firmware-guide/acpi/dsd/graph.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentation/firmware-guide/acpi/dsd/graph.rst
index 4341299aa937..0ced07cb1be3 100644
--- a/Documentation/firmware-guide/acpi/dsd/graph.rst
+++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
@@ -159,7 +159,7 @@ References
 
 [2] Devicetree. https://www.devicetree.org, referenced 2016-10-03.
 
-[3] Documentation/devicetree/bindings/graph.txt
+[3] Documentation/devicetree/bindings/graph.txt
 
 [4] Device Properties UUID For _DSD.
     https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf,
-- 
2.31.1

