Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABE451B736
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 06:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbiEEEmH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 May 2022 00:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiEEEmG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2022 00:42:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8B43D1FB;
        Wed,  4 May 2022 21:38:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F19761A8E;
        Thu,  5 May 2022 04:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7134AC385A4;
        Thu,  5 May 2022 04:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651725507;
        bh=xQ9ID9upe/l42cR8AxOMGLL42hRtsjZ2bTQqZA2aAMM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MY5C4u+rQgWKYZxYi6J9XzTl/9Fa73VDfAWhFgcBMZOsArXByshbjRTTPJuCbl0Bw
         Cuai5N/jRT4M8CxvA55PHlmaNK9/2utoeI07CGtrKWRIYVxtnaJf2qOoA9pkKEa80p
         U/1HwjeOf5KOX75JUI2CKzI8SE5DbAuF5UXz54ULs7tmB9ntCXLKZaA/0pytoKpcyf
         VA9D0LM7WuPmx/gNqe+GOdT8XlmK/5pPjgEFwYBVsv79QMg9sOyOgsZLcJHQtm33RD
         yqFSTMpAZhtYicrEEPe8g6KH6tbI0EWWWPA0bPTVXDR2z5DwAMf82H7M+Bezy+WJV/
         2FBJSUagDEy1w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     rjw@rjwysocki.net, alexandre.belloni@bootlin.com,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, mat.jonczyk@o2.pl,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Subject: Re: [PATCH 5/7] wil6210: remove debug message for unsupported PM event
References: <20220505015814.3727692-1-rui.zhang@intel.com>
        <20220505015814.3727692-6-rui.zhang@intel.com>
Date:   Thu, 05 May 2022 07:38:21 +0300
In-Reply-To: <20220505015814.3727692-6-rui.zhang@intel.com> (Zhang Rui's
        message of "Thu, 5 May 2022 09:58:12 +0800")
Message-ID: <875ymkzj9e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Zhang Rui <rui.zhang@intel.com> writes:

> Remove the useless debug message for unsupported PM event because it is
> noop in current code, and it gives a warning when a new event is
> introduced, which it doesn't care.

It's a debug message, not a warning, and only visible when debug
messages are enabled. Why do you want to remove it?

> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>

Is this really tested on a wil6210 device? Not that it matters, just
surprised to see a Tested-by for a wil6210 patch. It's not really common
hardware.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
