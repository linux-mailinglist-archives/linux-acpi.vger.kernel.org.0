Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D215A50D2
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Aug 2022 17:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiH2P7E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Aug 2022 11:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH2P7E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Aug 2022 11:59:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5D997B1E
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 08:59:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m2so8002076lfp.11
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 08:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=talea-agency.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ImyAP03QZwSKU7Qi7YDPr+5sWFlfw7ZtTUZiStF8GI0=;
        b=15ujsE4fq8GLwjUj079K/L9DDVTiUq1M3/tY3jiRBWjgEmxKU7cxBevewO0LhCiyez
         yXs4s4L6bFPVU4+8eEPXGvRUWX32Z5ZLFiDzWfLQrxVsq2gxgvxKlTUy3L02zYWqY0Ki
         mkWw53HI8SZKbFVj4jWsIxXXTrUuZdXZPAz8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ImyAP03QZwSKU7Qi7YDPr+5sWFlfw7ZtTUZiStF8GI0=;
        b=PUWVezNxQZtVVzTZ6fHfJ2i4eZYran1SIY+dWNRc7Tk147ynKlXYlY8ML2C9MmOA2T
         wvyAMHbSBekhiz/3GKl/68kl4VVaxJzAYIIlUvS0k9bgnlm6JVTrvCuRA3j8r4rmZCuo
         AWOfEDxjIhuCW/Mjttrm8c8wMCcZ+P+zeFM2vuYyApVTatA4VsjsoIXtRsJu78dLIHTF
         3VRcipneyfrsFZ1ZMUkjJUdaiH1+/Q1ejknbAyhS+6RxLgSA+9JzWq9IOv4ACnF7oXHs
         WHdvYHL/nPdEnKBi0SDXPywg4KHbf+Fhik31dLfBP6kyVXXH9UbBr6i/hkSLp2LdYFmq
         2tLw==
X-Gm-Message-State: ACgBeo12yGfyxCJZ0hjK7RfXGZmrAJp2kL6D9VClkacTAMWDKAAIU1We
        3hPikgMhINXxLS7z2BjqGc3nyZ+A1zVHHVfKmMdkN4vOYtL9xQ==
X-Google-Smtp-Source: AA6agR6aTd9R14UCrggF02FjQSyGdDOTmAJ4ABbtXoY+f59ZFy2qD8o5FUOpPK75orNXGbpSnVN2qO7vTpoUr29Nb5s=
X-Received: by 2002:a05:6512:3047:b0:494:716e:4f47 with SMTP id
 b7-20020a056512304700b00494716e4f47mr967722lfb.228.1661788741557; Mon, 29 Aug
 2022 08:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAPSsG-h_C+NC5Td1+s4-gyFMS+zi37OwHNaRvVFa7eDn65kOfA@mail.gmail.com>
In-Reply-To: <CAPSsG-h_C+NC5Td1+s4-gyFMS+zi37OwHNaRvVFa7eDn65kOfA@mail.gmail.com>
From:   Andres Sanchis <andres@talea-agency.com>
Date:   Mon, 29 Aug 2022 17:58:51 +0200
Message-ID: <CAPSsG-j0u8MsBO1meCjhUA13zh1u3BpR9MygpW=DsJeGcarpng@mail.gmail.com>
Subject: Re: Help Troubleshooting ACPI related issue
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi.  I hope this email suits well here.

I'm currently working on a project where we are facing a problem with
some intel based devices using ubuntu OS that randomly crash and the
only information we get about the error is a BERT fatal hardware error
message trace on the syslog after the device is rebooted. We would
like to understand the nature of this error and what we can do to fix
it.

I'm looking for someone who would be able/interested in helping us to
troubleshoot this issue.

If someone is interested please contact me so we can have a call to
discuss  availability/rates.

Best regards.
