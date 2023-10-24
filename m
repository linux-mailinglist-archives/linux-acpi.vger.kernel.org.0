Return-Path: <linux-acpi+bounces-869-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC147D4A26
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 10:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4401C2095A
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2912A21351
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Es5LaCKF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711E13AD9
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 07:09:39 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D4E110
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 00:09:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so35359405e9.3
        for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 00:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698131375; x=1698736175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bg3/yG5alTR9cURzI2G+r1/RbWGLer43z8qyypczxLw=;
        b=Es5LaCKFhseaBU5oll84kZYT2OmAJo7qfuMEdVFj5z5cMPOZwB04F9A0rA47M+NlQm
         uQqljutvsShk+pazg0qG45M6bfa+ncEdwNImh/yNTWeYuyYpwNqBqVFegUCT3uwn4CqR
         +agV5NPGRZXlVQy30QdF36xpPCRUsxmJp1SaEsQCwfBj9CS44dzve6xZ5wU0be1Z2QXl
         sfc6KcmwyxbLfT3miiDpVOtNLmhut6H0/uSwpx6tSrPuwm3TzeuAvPkipx9pgRxn1epS
         CHk3jAqyy4+1/Lp+0v2jPaGZxFsu3f8aNnukKz2enTGlL9biGtTkyZh5Rp+f8SQrdK3z
         nYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698131375; x=1698736175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bg3/yG5alTR9cURzI2G+r1/RbWGLer43z8qyypczxLw=;
        b=lMoIevB5+cRdlXfceIQwW+RyXef984jJ8Rasom2kJUEWECN+bxebRSH2nLpYkRc+s8
         kPgNksfqHiAhIPn/Xc9/pEzHG3sNxpYoxBv4HY3D6F1tRNLFZEuDQidhwFbphI1tFDCb
         jlYfTbOwUaUKivlfZtlNI+MEEM9NIkueX6wbwQIEguUJaJO7biNrDKAcoDM2E6zofP42
         xlfXb7EnLT0c2SrxNfC4iXXj0xdTwXozvXYm+z/Dqk4AlLDGDFdcUZN2RU57SRNqyk+U
         X393XPPutfG9ENsoW/PAxWBitMPuA20DFxUeb407nyM0TP1Vqnt3Y++fID5uzc3zmzaN
         WaIw==
X-Gm-Message-State: AOJu0YzNm+pgtSxYqXUiDzFon0X7jIQIIugLOsGFydWJSPoEOO6cwnnq
	p74+dIThSzhh3OM5iz1PQihoUw==
X-Google-Smtp-Source: AGHT+IG82Wy7z7LaS15pZRBGLYgELtLF6fUMo8x83zDPQE5+VC1wueXV6hw8d9oATcWQwSIY0XVuQQ==
X-Received: by 2002:a05:600c:4fc9:b0:402:8c7e:3fc4 with SMTP id o9-20020a05600c4fc900b004028c7e3fc4mr9410480wmq.30.1698131375586;
        Tue, 24 Oct 2023 00:09:35 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c45ca00b00407752f5ab6sm11368047wmo.6.2023.10.24.00.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 00:09:34 -0700 (PDT)
Date: Tue, 24 Oct 2023 10:09:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/4] ACPI: sysfs: Fix a potential out-of-bound write in
 create_of_modalias()
Message-ID: <6c38f870-8f89-4955-abd5-50439853e440@kadam.mountain>
References: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
 <004a9aa85dcc37d112443e133c9edfd7624cd47b.1698081019.git.christophe.jaillet@wanadoo.fr>
 <df33bc21-4792-4395-bbe0-4c8893818f6b@kadam.mountain>
 <ae1f9a0a-2058-4126-b716-44dc54449c4d@kadam.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gSLSPFJSYIsxf/4V"
Content-Disposition: inline
In-Reply-To: <ae1f9a0a-2058-4126-b716-44dc54449c4d@kadam.mountain>


--gSLSPFJSYIsxf/4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 24, 2023 at 09:08:26AM +0300, Dan Carpenter wrote:
> So I had a Smatch check for this kind of stuff but it was pretty junk.
> It also only looked for "modalias + len" and here the code is doing
> "&modalias[len]".
> 
> I can fix it up a bit today and look again at the warnings.  Here is the
> the check and the warnings as-is.

Alright.  Here is the new version.  :)

regards,
dan carpenter

--gSLSPFJSYIsxf/4V
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_snprintf_no_minus.c"

/*
 * Copyright (C) 2021 Oracle.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

#include "smatch.h"
#include "smatch_slist.h"
#include "smatch_extra.h"

static int my_id;

STATE(plus_equal);
STATE(minus_equal);

static bool is_plus_address(struct expression *expr)
{
	sval_t sval;

	if (expr->type != EXPR_PREOP ||
	    expr->op != '&')
		return false;

	expr = expr->unop;
	if (expr->type != EXPR_PREOP ||
	    expr->op != '*')
		return false;

	expr = expr->unop;
	if (expr->type != EXPR_BINOP ||
	    expr->op != '+')
		return false;

	if (get_implied_value(expr->right, &sval) && sval.value == 0)
		return false;

	return true;
}

static bool is_plus(struct expression *expr)
{
	struct expression *tmp;
	sval_t sval;

	tmp = get_assigned_expr(expr);
	if (tmp)
		expr = tmp;
	expr = strip_expr(expr);
	if (expr->type == EXPR_BINOP && expr->op == '+') {
		if (get_implied_value(expr->right, &sval) && sval.value == 0)
			return false;
		return true;
	}

	if (is_plus_address(expr))
		return true;

	if (get_state_expr(my_id, expr) == &plus_equal)
		return true;

	return false;
}

static bool is_minus(struct expression *expr)
{
	struct expression *tmp;

	tmp = get_assigned_expr(expr);
	if (tmp)
		expr = tmp;
	expr = strip_expr(expr);
	if (expr->type == EXPR_BINOP && expr->op == '-')
		return true;
	/*
	 * If, after calling strip_expr, the expression is still () that means
	 * it is an EXPR_STATEMENT and some kind of complicated macro.
	 */
	if (expr->type == EXPR_PREOP && expr->op == '(')
		return true;
	if (get_state_expr(my_id, expr) == &minus_equal)
		return true;
	return false;
}

static void match_snprintf(const char *fn, struct expression *expr, void *unused)
{
	struct expression *dest, *limit;
	char *name;

	dest = get_argument_from_call_expr(expr->args, 0);
	limit = get_argument_from_call_expr(expr->args, 1);
	dest = strip_expr(dest);
	limit = strip_expr(limit);
	if (!dest || !limit)
		return;

	if (!is_plus(dest))
		return;

	if (is_minus(limit))
		return;

	name = expr_to_str(limit);
	sm_warning("expected subtract in snprintf limit '%s'", name);
	free_string(name);
}

static void match_assign(struct expression *expr)
{
	if (expr->op == SPECIAL_ADD_ASSIGN)
		set_state_expr(my_id, expr->left, &plus_equal);

	if (expr->op == SPECIAL_SUB_ASSIGN)
		set_state_expr(my_id, expr->left, &minus_equal);
}

void check_snprintf_no_minus(int id)
{
	my_id = id;

	add_function_hook("snprintf", &match_snprintf, NULL);
	add_function_hook("scnprintf", &match_snprintf, NULL);

	add_hook(&match_assign, ASSIGNMENT_HOOK);
}


--gSLSPFJSYIsxf/4V--

