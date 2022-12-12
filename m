Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAA164A4A7
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Dec 2022 17:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiLLQQX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Dec 2022 11:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiLLQQW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Dec 2022 11:16:22 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584F513DCB
        for <linux-acpi@vger.kernel.org>; Mon, 12 Dec 2022 08:16:20 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3b56782b3f6so153018227b3.13
        for <linux-acpi@vger.kernel.org>; Mon, 12 Dec 2022 08:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yNd1eAuqiv2F0WkBq+nJSABq95q8VIjAGbGSeg2PsmY=;
        b=hX4bQy7AGTFJjKk24dDatWKf34vNwQ4xwdP7wjyKuzWOOPs83BhcDCTbC0SvEt4GNX
         qrbfkZnOrCb5vIVlMGD998Qci8DM0J22RgMovI4bnU2Sf5NyrtTR4eZQVTiZ0AztjiPm
         FJ9cJZmAzjSUZfxGdYyyaHt7s+jCTUnMThBjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNd1eAuqiv2F0WkBq+nJSABq95q8VIjAGbGSeg2PsmY=;
        b=7EwQR5SJfcE6ihjMMpV5hJRRVk6v9llW2JcEAK6Z+Ll8IF6g02XRQ8y3BMpDG9Z5/q
         FzG74FMM1+OMDyj2n5c63CdAgbFn0yQ+JbK08TTmEUimK8CFaaoQQxLkYCQZKsRUZERQ
         yYIBosjrMOMtFARmeaSDVfdMiPvj4rVei9aukyBURsS2+2dR7vNYpW/VB6ZVEyv0/LGx
         bn71Vj6rXoJaJG2yTcNzobnubiIQvGwxtIS7b4Blbqu+xJJmiiWfdTdi1UAJ/3I5pSL6
         t6Z0/7Zxt8+xL0cFVF+tAADThFCJVuw7R88EkI40POU8Dye1hWHZhgDe0XCTr7miriVg
         or2w==
X-Gm-Message-State: ANoB5pnrjahTQvYTJg6JdFqsxpusCaiPr3kczQSYznYN4xIAdspVRGtE
        S9+C5QH7Orm6YtwPxqVSZC0oTw==
X-Google-Smtp-Source: AA0mqf7e/QwJREEO+Dxt3D5UkAVDbrKZmbjiBOsHMooNxWY4JLdQAkGgvEXe91HjL5pk869wbg8wQA==
X-Received: by 2002:a05:7508:6699:b0:47:3bf0:f1ab with SMTP id dt25-20020a057508669900b000473bf0f1abmr1533110gbb.5.1670861779368;
        Mon, 12 Dec 2022 08:16:19 -0800 (PST)
Received: from meerkat.local ([142.113.79.147])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a404800b006feea093006sm6100115qko.124.2022.12.12.08.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:16:18 -0800 (PST)
Date:   Mon, 12 Dec 2022 11:16:13 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 0/9] CXL: Process event logs
Message-ID: <20221212161613.mz42m7n6eswjwdjv@meerkat.local>
References: <20221211-test-b4-v4-0-9f45dfeec102@intel.com>
 <Y5a88UgaE3EzJFQh@iweiny-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5a88UgaE3EzJFQh@iweiny-mobl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Dec 11, 2022 at 09:32:33PM -0800, Ira Weiny wrote:
> My apologies.  Please ignore this series.
> 
> I'm trying to use the new b4 send functionality and was trying to send this
> only to myself.  I'm not sure what went wrong.  The patches should be ok but
> this did not get sent to all the intended lists and people.
> 
> I'm going to resend this hopefully to all the right addresses this time.

Ira:

I don't think anything went wrong -- you probably used the new "reflect"
feature, right? It fills out the To: and Cc: headers but doesn't actually send
actual mail to those accounts. Mail servers don't actually pay any attention
to those headers -- all that matters is what destinations are given to the
server during the envelope negotiation.

I do realize that this is confusing. :/

Should I include anything in the output about this?

-K
