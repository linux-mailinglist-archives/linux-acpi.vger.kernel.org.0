Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A31568F0C
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Jul 2022 18:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiGFQZo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Jul 2022 12:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbiGFQZn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jul 2022 12:25:43 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A8D2613F
        for <linux-acpi@vger.kernel.org>; Wed,  6 Jul 2022 09:25:40 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id n12-20020a9d64cc000000b00616ebd87fc4so12168393otl.7
        for <linux-acpi@vger.kernel.org>; Wed, 06 Jul 2022 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Uk0kx353H+gGEfDDNFmV1k9XciWZTV5g6S3ovbgNaYc=;
        b=gQqyK8e6UjlfcdDaTwuapyo5u6WCZfyOyUo3o+rhjn0y6o6twgaREpXrfDzmOzwGI4
         Xf5d+/XrpNxcXy2P+S6Arj4mikQrOs7tn8Zi0G2PfPlx9DQA87CxYpyOLLtznadJxTdi
         YU7sooZaHsJFupUvH9P8JYZr92v53Ewf8CO0k3ftFj8+aClkoUt3Yeir2cznint1XJiZ
         4cnnfCCVb7Hw+AuxNnLfsLhkSiPepj+3DXTkepicubsvvsJ96h6vgKMiBtxHx7xscJfy
         hYzHaxW5ZBme1j+WHTF16ek8bjQKD3UIMwwyTBOCWbSiEqVVtQB8nsIb5WVv5H9A4LNz
         CKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Uk0kx353H+gGEfDDNFmV1k9XciWZTV5g6S3ovbgNaYc=;
        b=VadnteKfXo7zYUjjcpP7t+bWBJ7YAKO8d3ULelbdZRx/VfEioYEkylYCiol9p9nCDE
         qCrzgepKujqvpLwCDN7/2nvbLMHDKxclaMk3vWlvryn4rnPiZjDfZcpkRGAiCszS1E/s
         gSReXgJ5EkIK2Okh/9ovMRrUvfTYvUWHsFu+Csu5oj+DxmE7hMZhhLrNuMGz7sFKOUdb
         5Bt//PIH9BQxsEvcKbLuE3EZIDy4kBWBaZWBVtlwjHkZTLE+ZZA0mePOBnwt2/I5dXCD
         kIqsqXbNY4QS2lQAq4P0vNMtXoXroV6gsPsFDbF6D+BY7b0L+65rHENe3b6z7G23QhSr
         GFkA==
X-Gm-Message-State: AJIora9garFO5wStUvJGxZs+9hqkod306qNszN+4gDAN2FYFktcGnP64
        g80rDBLgImrz7yPzsPYkJBGquyo2N7XlLRP5parLWqzBlIQ=
X-Google-Smtp-Source: AGRyM1uBbeke8wh9mfu4ZJ+5+4KGZ7yZiqEh677cojeZ6bpzgdiE8hjHgHdURg0ZRw4xgz6IWLD+HWiH2GsizApoY9E=
X-Received: by 2002:a05:6830:1d5b:b0:616:de98:2556 with SMTP id
 p27-20020a0568301d5b00b00616de982556mr18845241oth.367.1657124739940; Wed, 06
 Jul 2022 09:25:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:4545:0:0:0:0:0 with HTTP; Wed, 6 Jul 2022 09:25:39 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   Kayla Manthey <avrielharry73@gmail.com>
Date:   Wed, 6 Jul 2022 16:25:39 +0000
Message-ID: <CAFSKFDY94cW50tP6DDz2oHbhf0ni4DDv1hxhbaqXPu50CZ_Xug@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

LS0gDQrQl9C00YDQsNCy0L4g0LTRgNCw0LPQsA0K0JLQtSDQvNC+0LvQsNC8LCDQtNCw0LvQuCDR
mNCwINC00L7QsdC40LLRgtC1INC80L7RmNCw0YLQsCDQv9GA0LXRgtGF0L7QtNC90LAg0L/QvtGA
0LDQutCwLCDQstC4INCx0LvQsNCz0L7QtNCw0YDQsNC8Lg0K
