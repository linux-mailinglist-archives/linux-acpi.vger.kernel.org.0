Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F114F9981
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Apr 2022 17:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiDHPcA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Apr 2022 11:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiDHPcA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Apr 2022 11:32:00 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF441CB178;
        Fri,  8 Apr 2022 08:29:53 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 505452C18FC;
        Fri,  8 Apr 2022 15:22:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B73492C1723;
        Fri,  8 Apr 2022 15:22:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649431360; a=rsa-sha256;
        cv=none;
        b=8ZWU70W9gddEhAHr96ZC3w/kXy70z+PZMdCHlv8rJrfIIctF4069NEYUww+nBiwuzHb9Th
        4+efs5UsTNGGYoq4JbUl4U+v88ANGs9G9JUSSWM8aKkFIXQ/rqIJC7YbmKg72nidu5rzuQ
        +hiRvXsG5NMht0rBoQzaELbOnqN4HqH+U3gGSPOTg8eGQflrcTRb1Gu3vx7581zGDl4KVp
        b7Bniu+2yzG/cK5rLhBHMRKtYPNmEB8CyObP5rPMQgM2xWhsQ2+ittRUR0TNkgw8i2oWnH
        Q+HOtne6Df+HxKmwyq7HaK8immRjrGWixu5l0199oavsuXmCiYhkPHt0lepcjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649431360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=PcisFdEGS984kRrr/jV6MSFBSKJSJtTc9mSbo7fwkmk=;
        b=jwgfUOV3niTwIvDLXZS3/P9iMLkAOkdQ73519pB0z7hJ2D3CI2Mu3MAyHFKzGlzRfzBwol
        RKfuJbEek2qLgber9xHlKbVKYk8i4DV0D0wIbsOBI0HT3L2aEBW7cVXgX0Dcgng94GtAei
        CowKUCirBgttvjUEJ6J0C5s2ahJLtMwYVBiFB27tDfuF5SmnNExGbH2dVQ9qgAEaHVfdGX
        9aCQrMI87eBMKSQnBRcCjzolvi/dWo1/xDYWAJaXfsBdIhFpxji9WJmEdgYMlHb+fLTHaI
        fphdSK1QyaixcUva9k9lzQ0W2SCsynClFTrjnJX4dDCklH2fU92pl7W/8kY9Zw==
ARC-Authentication-Results: i=1;
        rspamd-68f9d8f9d5-cr5h5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.239 (trex/6.7.1);
        Fri, 08 Apr 2022 15:22:41 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Decisive-Cellar: 69f2375f5dcab964_1649431361116_1853168669
X-MC-Loop-Signature: 1649431361116:3047169180
X-MC-Ingress-Time: 1649431361115
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4KZhnq6GGxz1K6;
        Fri,  8 Apr 2022 08:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649431360;
        bh=PcisFdEGS984kRrr/jV6MSFBSKJSJtTc9mSbo7fwkmk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=PACpE32tvuLpsuioLYe0IGGOODP3B+hcCUrXQCf7WZzir04Xh1CAPBrTpf6QpzX9y
         js3LD+Y757wDp4YhRUUUSf4NLAPd8gs1q2n0etscE5IiQc1VW17Qf8tgsE6/t6VSn5
         B6VWZnTPP4ze664xUUtyiAoE0Fwkk4vNuwvUKkegWRRZvFco4wQp3wCjGlxUxiipak
         KPah80angg44xaUYO9AlNoUC6v/tJNUU27Id+cfo+iPxNP2I0M7avbWbPWJpH8cgre
         FNwh0V+QqKRZv+7+EdGJLxkeFwn4m/OZSPFYsgeQIX4E68o4mDbFJpHQVzPJeObBTL
         5f53flUaNgKqw==
Date:   Fri, 8 Apr 2022 08:22:36 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, a.manzanares@samsung.com
Subject: Re: [PATCH v5 0/3] PCI/ACPI: add support for CXL _OSC
Message-ID: <20220408152236.d6bcs7ktdoy6lzeg@offworld>
References: <20220406023746.2807328-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220406023746.2807328-1-vishal.l.verma@intel.com>
User-Agent: NeoMutt/20201120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 05 Apr 2022, Vishal Verma wrote:

>Changes since v4[1]:
>- Collect an ack for patch 1 (Rafael)
>- Fix commit subject wording in patch 2 (Rafael)
>- Fix a debug print in patch 2 (Rafael)
>- Document the reasoning behind calculation of cxl hotplug support (David)
>- A few definition and variable name changes to make the new _OSC DWORDS
>  generic instead of CXL specific (Rafael)
>
>Add support for using the CXL definition of _OSC where applicable, and
>negotiating CXL specific support and control bits.
>
>Patch 1 is a preliminary cleanup that replaces open-coded pointer
>arithmetic to retrieve the Control DWORD with an inline helper.
>
>Patch 2 adds the new CXL _OSC UUID, and uses it instead of the PCI UUID
>when a root port is CXL enabled. It provides a fallback method for
>CXL-1.1 platforms that may not implement the CXL-2.0 _OSC.
>
>Patch 3 performs negotiation for the CXL specific _OSC support and
>control bits.
>
>I've tested these against a custom qemu[2], which adds the CXL _OSC (in
>addition to other CXL support). Specifically, _OSC support is added
>here[3].

For the series, feel free to add my:

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
