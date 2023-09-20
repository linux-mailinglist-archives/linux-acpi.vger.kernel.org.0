Return-Path: <linux-acpi+bounces-7-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F276A7A8BD2
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Sep 2023 20:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DB3281BAE
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Sep 2023 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC0319C
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Sep 2023 18:33:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0911A580
	for <linux-acpi@vger.kernel.org>; Wed, 20 Sep 2023 17:17:41 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9CAEA
	for <linux-acpi@vger.kernel.org>; Wed, 20 Sep 2023 10:17:38 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-773a5bb6fb6so399041785a.3
        for <linux-acpi@vger.kernel.org>; Wed, 20 Sep 2023 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695230257; x=1695835057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bj6Z0IsZaDjTDUtMG0ioxWXr9an6JP8+5MbbS1uSHxo=;
        b=PYNhApjAXPB0xvMOsZF1CF8rglZR9Hm3iIHUVU+0lJqgUPAwWorPdb2o3yxrd674HU
         IPQcqTyo5jpWLxkzHncN5PglfVx7dMyAe4mYL9ZofxuPT3VfOg8qxdkkCexuNt03YrP+
         nq8Em5Vk5HC/VP6DYms1BiFBy5yO9iFoc5Hds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230257; x=1695835057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bj6Z0IsZaDjTDUtMG0ioxWXr9an6JP8+5MbbS1uSHxo=;
        b=n7MIl6ELn7EJWRp8YSqSOa96SrEw9R2x8gpAcAz830oeGaN3+OODLhXnlurZ5zSLGu
         dYCdmJoZ0FqDiPojOfetwzF9QLDeeI3XJCUg48ssUFZHJj+GSklifG8b2H1Wv+xMPgVC
         xDVcIqe0qvZEgt8rdWNHDQZbxGHdkPvrJOzOC+18SlQiyvRpxWq5KwKY0MMWc5IpGkk1
         AU0Mrbz6siy63uoxqjHOUjYTEEzCt9hUPaYHqtlQSKmj9BwPev/9ZdOLk5l5JgrXa3DF
         /lqbrruXINVBpfWle56+A6VeLSzhfK2oyz+TwZkb9i5dlrnfyvXMdFBDsTifysgIY+zk
         lRCw==
X-Gm-Message-State: AOJu0Yx40EMcjq5DL8IoSWbsKKoJzKxbTN0rLIds/jC285hMF+1XpAvz
	PGG2gi9uMwZ48wChlN12gAR2eD4O+GJpQhQg3f0=
X-Google-Smtp-Source: AGHT+IHQjKHOH8VKOa2/KEcCe+QjPsgKhcmMyO+N6xh5zrrDfSafak17cTwAA9ws10V25OhEP0QwYQ==
X-Received: by 2002:a05:620a:4556:b0:770:96a1:558b with SMTP id u22-20020a05620a455600b0077096a1558bmr3802979qkp.14.1695230257675;
        Wed, 20 Sep 2023 10:17:37 -0700 (PDT)
Received: from meerkat.local ([209.226.106.110])
        by smtp.gmail.com with ESMTPSA id s17-20020a05620a031100b0076f319acaedsm4955440qkm.48.2023.09.20.10.17.37
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 10:17:37 -0700 (PDT)
Date: Wed, 20 Sep 2023 13:17:28 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-acpi@vger.kernel.org
Subject: Re: This list is being migrated to the new infrastructure
Message-ID: <20230920-connector-oversleep-0d2b4b@meerkat>
References: <20230920-dweeb-trowel-49c3bc@meerkat>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920-dweeb-trowel-49c3bc@meerkat>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 12:35:17PM -0400, Konstantin Ryabitsev wrote:
> Hello, all:
> 
> This list is being migrated to the new vger infrastructure. This should be a
> fully transparent process and you don't need to change anything about how you
> participate with the list or how you receive mail.
> 
> There will be a brief 20-minute delay with archives on lore.kernel.org. I will
> follow up once the archive migration has been completed.

This work is now completed. I will monitor the performance to make
sure that the new infrastructure is still successfully coping with the
email traffic.

If you notice any problems, please report them to helpdesk at kernel.org.

-K

