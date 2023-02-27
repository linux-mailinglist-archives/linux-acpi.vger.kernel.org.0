Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7B16A35F6
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Feb 2023 01:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjB0AfP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 26 Feb 2023 19:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjB0AfO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Feb 2023 19:35:14 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94A013534
        for <linux-acpi@vger.kernel.org>; Sun, 26 Feb 2023 16:35:13 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ee7so19399238edb.2
        for <linux-acpi@vger.kernel.org>; Sun, 26 Feb 2023 16:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677458112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5XkmLJP2m6PiET/pmnSWjwK1ismWPfiJiZeRG498oF4=;
        b=ZjJgg9Aj+JQ3WeWSQkRKZUwFsvhY8R4ye5SN1PTqVj545KUkfg8iFvDoLpTYBf5tEQ
         b0AZzTF269ByxINCkewZ99bgWVtXqDzuMeYkWuZJ2GpRBMtUwccBD0Ty3e3kTqn/hNS6
         owYuaq2EiGAAdhHRnUlpRKEGzFoQL/e9vA9g8BJv8M2JS73y83w/zu5Z9vKChpsFBLlc
         oISEYC4j4oLUEDzzvkscux3ollWFItYONTTXuMnTZwUeOB3466TBw/X0SsgPffPM3rpV
         u0gEgWtB9oYoptDygM7G16BNDjCzcWh4yGGAY3d+2/29GCnpsdnUlYCcty35sZIjhvPz
         Q18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677458112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XkmLJP2m6PiET/pmnSWjwK1ismWPfiJiZeRG498oF4=;
        b=JLFIOjxVNC9ExR5KPyW3fKfA6glP5A2SCKZjDEg0CQbfMCdaEP7syJL/2Y8HhrkoT8
         gDZUs1qYt4aoUm8cVxG5eJnvnTHZGBXvizpCd43w33zFAaNq31t0uh/X1LyPH1xVN1sY
         L++1ShgSu8HKqc0MtIsSdxQWM2m+IOMYUS5PhLu/gwZlA82huCaZg7AZJCyZzybaYr6P
         bkBFLTGllEO89cLbW+G3eYBFf0HPpGawLUFQ/84v8Nz3fV5uFRQ9g5KMb9Vtrc0B3+OE
         5Pgs23BwYStjWFRgMQhCHlGW/JPzbrYAxOxd/FMxAPEE9ANNReXI5aGoObw8XUzFQqeB
         4zqw==
X-Gm-Message-State: AO0yUKVH9jkPmgIvNlm+usFyohu3yHAWSdNwN16rB02BtkyzFBIc5NO8
        65kxnoSkqF5ElBhkgUlc4iDDt3exQt7FLAZ+5PQ=
X-Google-Smtp-Source: AK7set+Qf79rKyOUxeRM/Osur561BrwNGvg13O85VUYwt5sEuzl2Voe6OH3R/q4ZSzv3VO40pBImNm9TvQLjp/5QN3Q=
X-Received: by 2002:a17:906:6d07:b0:8af:4963:fb08 with SMTP id
 m7-20020a1709066d0700b008af4963fb08mr15115189ejr.15.1677458111960; Sun, 26
 Feb 2023 16:35:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:1b15:b0:8dd:d3ef:8fcd with HTTP; Sun, 26 Feb 2023
 16:35:11 -0800 (PST)
From:   Birgit Heiland <birgitheiland65@gmail.com>
Date:   Sun, 26 Feb 2023 16:35:11 -0800
Message-ID: <CA+CGTONPjpAf5eYN5HwG3piNVZtrVp3DG4KatPrEuk9qbd-pwg@mail.gmail.com>
Subject: We finance viable projects only
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_99,BAYES_999,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Attention: Sir,

Our Company is willing, ready to help you grow your network and offer
you Loan funds to complete and fund your existing Projects. We can
send you our Company Terms and Condition after review of your project
plan and executive summary of your project, if you are serious and
Interested contact us for further Information:

Email: birgitheiland65@gmail.com

Thanks and best regards

Birgit Heiland
