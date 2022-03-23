Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A514E4A30
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Mar 2022 01:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbiCWAtt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Mar 2022 20:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240979AbiCWAts (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Mar 2022 20:49:48 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6242B188;
        Tue, 22 Mar 2022 17:48:18 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6130762181B;
        Wed, 23 Mar 2022 00:48:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a316.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 362CA6220C8;
        Wed, 23 Mar 2022 00:47:57 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a316.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.230.141 (trex/6.5.3);
        Wed, 23 Mar 2022 00:48:17 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooing-Harmony: 09b5388473cb8398_1647996497198_138382780
X-MC-Loop-Signature: 1647996497198:3884895152
X-MC-Ingress-Time: 1647996497198
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a316.dreamhost.com (Postfix) with ESMTPSA id 4KNV7w2TByz1B;
        Tue, 22 Mar 2022 17:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1647996477;
        bh=axK3an3G6/3umiaNKJN/ZVM+j2MnC1T8WlF/xM/eLP0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=V0LXkz3C8ZvVyyeIQ9MwQQX4Q9O608A0uT/mhQMdx+aYRFhhG9rJ483BZKj4/I5As
         oBphSlPyOpYIh1wHGEzLH1RvC37YM/U2AL4g/R7lr/O5ZLN0E1aBPTCU8pRqZmbdmY
         raMR5UokpDKjtu3crUV45O644xfdjY4vPDtIBd5LbaqCCta71wRZ/nLQ6rkXgIuhMx
         /qXtPfosmWK8yzFZz7ngpVNnS2lL38bKy8soGNZ8mb9pedJHCGz2uiLhyJLA8AtQDI
         BFCxG8/JCA7/w3CjaRYlSlGfTcjObqHeWzi6GFQdo8t9jde4a4sI+KaWhZnNXYYqMW
         SQD/GjQlDi0xA==
Date:   Tue, 22 Mar 2022 17:47:53 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/2] acpi/pci_root: negotiate CXL _OSC
Message-ID: <20220323004753.qkngm4yctprcgvoc@offworld>
References: <20220318213004.2287428-1-vishal.l.verma@intel.com>
 <20220318213004.2287428-3-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220318213004.2287428-3-vishal.l.verma@intel.com>
User-Agent: NeoMutt/20201120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 18 Mar 2022, Vishal Verma wrote:

>+/* Max possible _OSC capability DWORDS */
>+#define OSC_CAPABILITY_DWORDS_MAX		5
>+
> /* Indexes into _OSC Capabilities Buffer (DWORDs 2 & 3 are device-specific) */
> #define OSC_QUERY_DWORD				0	/* DWORD 1 */
> #define OSC_SUPPORT_DWORD			1	/* DWORD 2 */
> #define OSC_CONTROL_DWORD			2	/* DWORD 3 */
>+#define OSC_CXL_SUPPORT_DWORD			3	/* DWORD 4 */
>+#define OSC_CXL_CONTROL_DWORD			4	/* DWORD 5 */

Shouldn't all this be in patch 1/2 (and also as enum maybe)? Or at least
the define OSC_CAPABILITY_DWORDS_MAX instead of having to do:

>-static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 support)
>+static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask,
>+					    u32 support, u32 *cxl_mask,
>+					    u32 cxl_support)
> {
>	u32 req = OSC_PCI_EXPRESS_CAPABILITY_CONTROL;
>	struct acpi_pci_root *root;
>	acpi_status status;
>-	u32 ctrl, capbuf[6];
>+	u32 ctrl, cxl_ctrl = 0, capbuf[OSC_CAPABILITY_DWORDS_MAX];

... which btw why is capbuf 6 in the previous patch and now 5 in this one?
Sorry if I missed anything obvious here, just seems odd.

And also it's ugly to just add extra params to acpi_pci_osc_control_set()
and have callers do do:

>+	status = acpi_pci_osc_control_set(handle, &control, support,
>+					  &cxl_control, cxl_support);

And this sort of thing happens all over the patch with struct acpi_pci_root.
So the whole handling of the _OSC state of support/control bits imo really
wants to be consolidated between CXL and non-CXL.

Thanks,
Davidlohr
