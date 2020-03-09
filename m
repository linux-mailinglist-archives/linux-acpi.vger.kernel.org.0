Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 837E017E158
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2020 14:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgCINiC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Mar 2020 09:38:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:48597 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgCINiC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Mar 2020 09:38:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 06:38:01 -0700
X-IronPort-AV: E=Sophos;i="5.70,533,1574150400"; 
   d="scan'208";a="353368911"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 06:37:59 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id C032B20AC3; Mon,  9 Mar 2020 15:37:57 +0200 (EET)
Date:   Mon, 9 Mar 2020 15:37:57 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, kernel@pengutronix.de,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] Documentation: ACPI: fix port numbering example
Message-ID: <20200309133757.GS5379@paasikivi.fi.intel.com>
References: <20200305145601.3467-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305145601.3467-1-m.felsch@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Marco,

Thanks for the patch.

On Thu, Mar 05, 2020 at 03:56:01PM +0100, Marco Felsch wrote:
> If I understood it right the ports should be numbered using the "port"
> property and not the "reg" property. I stumbled over it during
> extending the v4l2_fwnode_parse_link() helper which also use the "port"
> property.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Hi,
> 
> I don't know if this is right since I'm not a ACPI guy *sorry*
> Anyway reading the doc description and the v4l2_fwnode_parse_link() code
> give me a 2/3 chance.

Looking at the documentation, this indeed seems to be a bug in the
documentation. The code is right, as is the example. As the property was
previously called "port", there is no actual harm even if someone just read
the documentation, and not the examples or the code parsing this.

The buggy patch is a4138e7c12287268348cc2dcad414a62c515d77a .

Could you use this instead?

diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentation/firmware-guide/acpi/dsd/graph.rst
index 1a6ce7afba5ea..2f19a0487b18c 100644
--- a/Documentation/firmware-guide/acpi/dsd/graph.rst
+++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
@@ -56,7 +56,7 @@ package would be::
 
     Package() { "endpoint@0", "EP40" }
 
-Each port node contains a property extension key "port", the value of which is
+Each port node contains a property extension key "reg", the value of which is
 the number of the port. Each endpoint is similarly numbered with a property
 extension key "reg", the value of which is the number of the endpoint. Port
 numbers must be unique within a device and endpoint numbers must be unique

-- 
Sakari Ailus
