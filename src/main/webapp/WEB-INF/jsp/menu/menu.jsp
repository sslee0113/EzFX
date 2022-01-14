<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
						<div id="leftMenu" class="easyui-accordion" data-options="fit:true,border:false,animate:false" style="height:300px;">
							<ul class="easyui-tree" data-options="lines:true">
								<li>
									<span>외환 거래</span>
									<ul>
										<li data-options="state:'closed'">
											<span>환전</span>
											<ul>
												<li>
													<span>
														<a id="" class="easyui-linkbutton" href="${pageContext.request.contextPath}/exchange/exchangeBuy" data-options="plain:true">외국통화 매입</a><br/>
													</span>
												</li>
												<li>
													<span>
														<a id="" class="easyui-linkbutton" href="${pageContext.request.contextPath}/exchange/exchangeSell">외국통화 매도</a><br/>
													</span>
												</li>
												<li>
													<span>
														<a id="" class="easyui-linkbutton" href="${pageContext.request.contextPath}/exchange/exchangeList">환전내역 조회</a><br/>
													</span>
												</li>
											</ul>
										</li>
										<li>
											<span>송금</span>
											<ul>
												<li>
													<span>
														<a id="" href="${pageContext.request.contextPath}/remittance/remittance">해외송금</a><br/>
													</span>
												</li>
												<li>
													<span>
														<a id="" href="${pageContext.request.contextPath}/remittance/remittanceList">해외송금 조회</a><br/>
													</span>
												</li>
											</ul>
										</li>
										<li>index.html</li>
										<li>about.html</li>
										<li>welcome.html</li>
									</ul>
								</li>
							</ul>
						</div>